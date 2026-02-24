import { Router, Request, Response } from 'express';
import { historyService } from '../services/HistoryService';
import { CreateCalculationDTO } from '../models/CalculationRecord';

const router = Router();

/**
 * GET /history - Get all calculations
 */
router.get('/', async (req: Request, res: Response) => {
  try {
    const history = await historyService.getHistory();
    res.json(history);
  } catch (error) {
    console.error('Error fetching history:', error);
    res.status(500).json({ error: 'Failed to fetch history' });
  }
});

/**
 * GET /history/:id - Get calculation by ID
 */
router.get('/:id', async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const calculation = await historyService.getById(id);

    if (!calculation) {
      return res.status(404).json({ error: 'Calculation not found' });
    }

    res.json(calculation);
  } catch (error) {
    console.error('Error fetching calculation:', error);
    res.status(500).json({ error: 'Failed to fetch calculation' });
  }
});

/**
 * POST /history - Add new calculation
 */
router.post('/', async (req: Request, res: Response) => {
  try {
    const { operand1, operator, operand2, result, displayText, userId } = req.body;

    // Validate required fields
    if (!operand1 || !operator || !operand2 || !result) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const dto: CreateCalculationDTO = {
      operand1,
      operator,
      operand2,
      result,
      displayText: displayText || `${operand1} ${operator} ${operand2} = ${result}`,
      timestamp: new Date(),
      userId,
    };

    const record = await historyService.addCalculation(dto);
    res.status(201).json(record);
  } catch (error) {
    console.error('Error adding calculation:', error);
    res.status(500).json({ error: 'Failed to add calculation' });
  }
});

/**
 * DELETE /history/:id - Delete calculation by ID
 */
router.delete('/:id', async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const deleted = await historyService.deleteById(id);

    if (!deleted) {
      return res.status(404).json({ error: 'Calculation not found' });
    }

    res.json({ message: 'Calculation deleted' });
  } catch (error) {
    console.error('Error deleting calculation:', error);
    res.status(500).json({ error: 'Failed to delete calculation' });
  }
});

/**
 * DELETE /history - Clear all history
 */
router.delete('/', async (req: Request, res: Response) => {
  try {
    await historyService.clearHistory();
    res.json({ message: 'History cleared' });
  } catch (error) {
    console.error('Error clearing history:', error);
    res.status(500).json({ error: 'Failed to clear history' });
  }
});

export default router;
