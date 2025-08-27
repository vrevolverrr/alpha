# 📈 Stock Market Simulation

The game features a sophisticated stock market simulation using **Geometric Brownian Motion (GBM)** to model realistic price movements.

## Stock Market Mechanics

**Available Stocks**: 10 stocks across 5 business sectors

| Sector | Stocks | Risk Levels | ESG Ratings |
|--------|--------|-------------|-------------|
| Technology | Quantum Tech (QTS), V Robotics (VRX) | High, Medium | 30, 15 |
| E-commerce | GlobalCart (GCT), ShopGo (SGI) | High, High | 5, 5 |
| F&B | FreshFeast (FST), FastFoods (FFF) | Medium, Medium | 35, 0 |
| Pharmaceutical | BioNova (BNA), Mystica (MYS) | Medium, Medium | 25, 10 |
| Social Media | SocialSphere (SOC), AlphaMedia (AMG) | Low, High | 10, 0 |

## Price Simulation Algorithm

**Geometric Brownian Motion Formula**:
```
S(t) = S₀ × exp((μ - σ²/2) × dt + σ × √dt × Z)
```

Where:
- `S₀`: Initial stock price
- `μ`: Drift rate (expected return)
- `σ`: Volatility
- `dt`: Time step (1 round)
- `Z`: Random normal variable N(0,1)

**Market Influences**:
- **Economic Cycle Impact**: 
  - Depression: -50% sentiment
  - Recession: 0% sentiment  
  - Recovery: +50% sentiment
  - Boom: +100% sentiment

- **World Event Impact**: ±100% sector-specific trends
- **Sector Trend Drift**: 0.8 weight factor
- **Market Sentiment Drift**: 0.6 weight factor

## Investment Mechanics

**ESG Stock Benefits**:
- First-time purchase of ESG stocks (rating > 0) awards ESG points
- Selling all shares of ESG stock removes ESG points
- Higher ESG ratings provide better long-term stability

**Portfolio Tracking**:
- FIFO (First In, First Out) selling methodology
- Real-time profit/loss calculations
- Historical performance tracking
- Percentage and absolute return metrics

---

*Part of the [IIC Cashflow Game 2025](../../README.md) documentation*