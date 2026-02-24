import React, { useState, useEffect } from 'react';
import { CalculationRecord } from '../models';
import { historyService } from '../services/HistoryService';

interface HistoryPanelProps {
  history: CalculationRecord[];
  isLoading?: boolean;
  onReplay: (result: string) => void;
  onClear: () => void;
}

export const HistoryPanel: React.FC<HistoryPanelProps> = ({
  history,
  isLoading = false,
  onReplay,
  onClear,
}) => {
  const isEmpty = !history || history.length === 0;

  const handleReplay = (index: number) => {
    const result = historyService.replayCalculation(index);
    if (result) {
      onReplay(result);
    }
  };

  return (
    <div className="history-panel">
      <h3>History</h3>

      {isLoading && <p className="history-loading">Loading...</p>}

      {isEmpty && !isLoading && <p className="history-empty">No calculations yet</p>}

      {!isEmpty && !isLoading && (
        <>
          <ul className="history-list">
            {history.map((calculation, index) => (
              <li key={calculation.id || index} className="history-item">
                <button
                  className="history-text"
                  onClick={() => handleReplay(index)}
                  title={`Replay: ${calculation.displayText}`}
                >
                  {calculation.displayText}
                </button>
              </li>
            ))}
          </ul>

          <button className="btn btn-clear" onClick={onClear} style={{ width: '100%' }}>
            Clear History
          </button>
        </>
      )}
    </div>
  );
};
