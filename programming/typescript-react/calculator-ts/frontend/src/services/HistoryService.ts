import { CalculationRecord } from '../models';
import axios from 'axios';

/**
 * History Service - Manages calculation history with API integration
 * Handles both in-memory cache and database persistence
 */
export class HistoryService {
  private static readonly MAX_ITEMS = 50;
  private static readonly API_BASE = '/api/history';
  private inMemoryHistory: CalculationRecord[] = [];

  /**
   * Add calculation to history (persists to API/database)
   */
  async addCalculation(
    operand1: string,
    operator: string,
    operand2: string,
    result: string
  ): Promise<CalculationRecord> {
    const record: CalculationRecord = {
      operand1,
      operator,
      operand2,
      result,
      timestamp: new Date(),
      displayText: `${operand1} ${operator} ${operand2} = ${result} (${new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })})`,
    };

    try {
      // POST to backend API
      const response = await axios.post<CalculationRecord>(HistoryService.API_BASE, record);
      const savedRecord = response.data;

      // Add to in-memory cache (newest first)
      this.inMemoryHistory.unshift(savedRecord);

      // Enforce max items
      if (this.inMemoryHistory.length > HistoryService.MAX_ITEMS) {
        this.inMemoryHistory = this.inMemoryHistory.slice(0, HistoryService.MAX_ITEMS);
      }

      return savedRecord;
    } catch (error) {
      console.error('Failed to save calculation to history:', error);
      // Fallback to in-memory only if API fails
      this.inMemoryHistory.unshift(record);
      if (this.inMemoryHistory.length > HistoryService.MAX_ITEMS) {
        this.inMemoryHistory = this.inMemoryHistory.slice(0, HistoryService.MAX_ITEMS);
      }
      return record;
    }
  }

  /**
   * Get all calculations from history (API + in-memory)
   */
  async getHistory(): Promise<CalculationRecord[]> {
    try {
      const response = await axios.get<CalculationRecord[]>(HistoryService.API_BASE);
      this.inMemoryHistory = response.data;
      return response.data;
    } catch (error) {
      console.error('Failed to fetch history from API:', error);
      // Return in-memory cache if API fails
      return this.inMemoryHistory;
    }
  }

  /**
   * Get in-memory history (cached)
   */
  getLocalHistory(): CalculationRecord[] {
    return [...this.inMemoryHistory];
  }

  /**
   * Replay a calculation from history
   */
  replayCalculation(index: number): string | null {
    if (index < 0 || index >= this.inMemoryHistory.length) {
      return null;
    }
    return this.inMemoryHistory[index].result;
  }

  /**
   * Clear history (both local and API)
   */
  async clearHistory(): Promise<void> {
    try {
      await axios.delete(HistoryService.API_BASE);
      this.inMemoryHistory = [];
    } catch (error) {
      console.error('Failed to clear history from API:', error);
      // Fallback: clear in-memory only
      this.inMemoryHistory = [];
    }
  }

  /**
   * Clear history item by ID
   */
  async deleteHistoryItem(id: string): Promise<void> {
    try {
      await axios.delete(`${HistoryService.API_BASE}/${id}`);
      this.inMemoryHistory = this.inMemoryHistory.filter(item => item.id !== id);
    } catch (error) {
      console.error('Failed to delete history item:', error);
      this.inMemoryHistory = this.inMemoryHistory.filter(item => item.id !== id);
    }
  }
}

export const historyService = new HistoryService();
