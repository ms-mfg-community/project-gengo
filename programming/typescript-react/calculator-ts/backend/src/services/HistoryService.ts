/**
 * In-Memory Database Service - Development/testing
 * In production, replace with Azure SQL or other persistent store
 */
import { CalculationRecord, CreateCalculationDTO } from '../models/CalculationRecord';
import { v4 as uuidv4 } from 'crypto';

export class HistoryService {
  private static readonly MAX_ITEMS = 50;
  private static instance: HistoryService;
  private history: CalculationRecord[] = [];

  private constructor() {}

  static getInstance(): HistoryService {
    if (!HistoryService.instance) {
      HistoryService.instance = new HistoryService();
    }
    return HistoryService.instance;
  }

  /**
   * Add calculation to history
   */
  async addCalculation(dto: CreateCalculationDTO): Promise<CalculationRecord> {
    const record: CalculationRecord = {
      id: uuidv4(),
      ...dto,
      timestamp: new Date(dto.timestamp),
    };

    // Add to beginning (newest first)
    this.history.unshift(record);

    // Enforce max items
    if (this.history.length > HistoryService.MAX_ITEMS) {
      this.history = this.history.slice(0, HistoryService.MAX_ITEMS);
    }

    return record;
  }

  /**
   * Get all calculations
   */
  async getHistory(): Promise<CalculationRecord[]> {
    return [...this.history];
  }

  /**
   * Get calculation by ID
   */
  async getById(id: string): Promise<CalculationRecord | undefined> {
    return this.history.find(item => item.id === id);
  }

  /**
   * Delete calculation by ID
   */
  async deleteById(id: string): Promise<boolean> {
    const index = this.history.findIndex(item => item.id === id);
    if (index !== -1) {
      this.history.splice(index, 1);
      return true;
    }
    return false;
  }

  /**
   * Clear all history
   */
  async clearHistory(): Promise<void> {
    this.history = [];
  }

  /**
   * Get history for specific user
   */
  async getHistoryByUserId(userId: string): Promise<CalculationRecord[]> {
    return this.history.filter(item => item.userId === userId);
  }

  /**
   * Get history count
   */
  getCount(): number {
    return this.history.length;
  }
}

export const historyService = HistoryService.getInstance();
