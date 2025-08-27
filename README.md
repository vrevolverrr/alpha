# Alpha - IIC Cashflow Game 2025

<div align="center">
  <img src="assets/images/logo/cashflow.png" alt="Cashflow Game Logo" width="300"/>
  
  **The companion app for the NTU Investment Interactive Club Cashflow Game**
  
  A comprehensive digital financial literacy board game designed to teach money management, investment strategies, and entrepreneurship within Singapore's economic landscape.

  ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white)
  ![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white)
  ![iOS](https://img.shields.io/badge/iOS-000000?style=flat&logo=ios&logoColor=white)
  ![Version](https://img.shields.io/badge/version-0.4.1--build.4-blue)
</div>

---

## 📋 Table of Contents

- [Introduction](#introduction)
  - [Project Overview](#project-overview)
  - [Mission & Motivation](#mission--motivation)
- [Technical Stack](#technical-stack)
  - [Architecture & Patterns](#architecture--patterns)
  - [State Management](#state-management)
  - [Project Structure](#project-structure)
- [Game Features](#game-features)
  - [Account Management System](#account-management-system)
  - [Stock Market Simulation](#stock-market-simulation)
  - [Career Progression System](#career-progression-system)
  - [Business Management](#business-management)
  - [Asset Management](#asset-management)
  - [Budgeting System](#budgeting-system)
  - [ESG Integration](#esg-integration)
  - [Economic Cycles](#economic-cycles)
  - [World Events](#world-events)
  - [Personal Life Progression](#personal-life-progression)
  - [Education System](#education-system)
  - [Loans and Debt](#loans-and-debt)
  - [Scoring Formula](#scoring-formula)
- [Game Rules](#game-rules)
- [Installation & Setup](#installation--setup)
- [Contributing](#contributing)
- [License](#license)

---

## 🎯 Introduction

### Project Overview

**Alpha - IIC Cashflow Game 2025** is an innovative digital board game developed by NTU's Investment Interactive Club (IIC) as part of their AY24/25 digitalization efforts. This iOS-exclusive Flutter application transforms complex financial concepts into an engaging, interactive learning experience.

The game challenges players to navigate Singapore's financial landscape through strategic decision-making across multiple domains: career advancement, stock market investments, business management, asset acquisition, and personal life progression. Players compete to maximize their final score through a sophisticated scoring system that balances wealth accumulation, happiness, debt management, and ESG (Environmental, Social, Governance) contributions.

### Mission & Motivation

Our mission is to democratize financial education by making it accessible, practical, and engaging. In an era where financial transactions increasingly rely on digital platforms, this game empowers players to:

- **Master Financial Decision-Making**: Experience real-world financial scenarios in a risk-free environment
- **Understand Investment Strategies**: Learn stock market dynamics, portfolio management, and ESG investing
- **Develop Entrepreneurial Skills**: Navigate business creation, competition, and strategic growth
- **Embrace Sustainable Finance**: Discover how ESG factors influence modern financial success
- **Build Financial Literacy**: Gain practical knowledge of budgeting, loans, and wealth management

---

## 🛠 Technical Stack

### Architecture & Patterns

- **Framework**: Flutter (targeting iOS exclusively)
- **Language**: Dart (SDK >=3.3.1 <4.0.0)
- **Architecture**: Modular service-oriented architecture with clear separation of concerns
- **Design Pattern**: Manager pattern for game systems, Observer pattern for state updates

### State Management

- **Primary**: Provider package for reactive state management
- **Local State**: ChangeNotifier for individual components
- **Global State**: GetIt service locator for singleton game managers
- **Data Flow**: Unidirectional data flow with clear manager responsibilities

### Project Structure

```
lib/
├── logic/                    # Core game logic and business rules
│   ├── accounts_logic.dart   # Financial account management
│   ├── financial_market_logic.dart # Stock market simulation
│   ├── business_logic.dart   # Business creation and management
│   ├── career_logic.dart     # Career progression system
│   ├── economy_logic.dart    # Economic cycle management
│   ├── game_logic.dart       # Main game orchestration
│   └── data/                 # Game data models
├── ui/                       # User interface components
│   ├── common/              # Reusable UI components
│   └── screens/             # Game screen implementations
├── services.dart            # Global service providers
└── main.dart               # Application entry point
```

**Key Dependencies**:
- `provider`: State management and reactive programming
- `get_it`: Dependency injection and service location
- `lottie`: Animation support for enhanced UX
- `vector_math`: Mathematical operations for game calculations
- `logging`: Comprehensive logging system

---

## 🎮 Game Features

### 💰 Account Management System

Players manage three distinct account types, each serving specific purposes in the financial ecosystem:

#### Account Types & Interest Rates

1. **Savings Account** (2.5% annual interest)
   - **Purpose**: Primary spending account for purchases
   - **Funding**: Manual allocation through budgeting system
   - **Features**: Unbudgeted income tracking, immediate accessibility

2. **Investment Account** (4.5% annual interest)  
   - **Purpose**: Stock trading and investment activities
   - **Funding**: Manual allocation through budgeting system
   - **Features**: Portfolio management, share ownership tracking

3. **CPF Account** (12% annual interest)
   - **Purpose**: Retirement savings (Singapore's Central Provident Fund)
   - **Funding**: Automatic 20% of salary contribution
   - **Restrictions**: Cannot be used for purchases (counts toward final assets)

#### Financial Mechanics

**Interest Calculation**: Applied at the end of each round
```dart
newBalance = currentBalance × (1 + interestRate/100)
```

**Purchase Priority**: Funds deducted in order:
1. Savings Account balance
2. Investment Account balance  
3. Unbudgeted savings
4. Transaction fails if insufficient funds

**Initial Balances**:
- Savings: $4,000
- Investment: $1,000
- CPF: $0

---

### 📈 Stock Market Simulation

The game features a sophisticated stock market simulation using **Geometric Brownian Motion (GBM)** to model realistic price movements.

#### Stock Market Mechanics

**Available Stocks**: 10 stocks across 5 business sectors

| Sector | Stocks | Risk Levels | ESG Ratings |
|--------|--------|-------------|-------------|
| Technology | Quantum Tech (QTS), V Robotics (VRX) | High, Medium | 30, 15 |
| E-commerce | GlobalCart (GCT), ShopGo (SGI) | High, High | 5, 5 |
| F&B | FreshFeast (FST), FastFoods (FFF) | Medium, Medium | 35, 0 |
| Pharmaceutical | BioNova (BNA), Mystica (MYS) | Medium, Medium | 25, 10 |
| Social Media | SocialSphere (SOC), AlphaMedia (AMG) | Low, High | 10, 0 |

#### Price Simulation Algorithm

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

#### Investment Mechanics

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

### 🏢 Career Progression System

The career system offers 8 distinct career paths with skill-based progression and realistic Singapore salary structures.

#### Career Sectors & Progression

| Career Path | Entry Level | Mid Level | Senior Level | Top Level |
|-------------|-------------|-----------|--------------|-----------|
| **Food Delivery** | Delivery Rider ($6,400) | - | - | - |
| **Marketing** | Marketing Assistant ($4,500) | Marketing Manager ($7,200) | - | - |
| **Culinary** | Assistant Chef ($5,000) | Executive Chef ($7,900) | - | - |
| **Banking** | Banking Associate ($4,000) | Banking Analyst ($6,800) | Managing Director ($9,400) | - |
| **Programming** | Junior Programmer ($4,400) | Senior Programmer ($9,300) | Project Manager ($12,500) | - |
| **Engineering** | Junior Engineer ($3,900) | Senior Engineer ($8,400) | Executive Engineer ($13,400) | - |
| **Medicine** | Houseman ($3,700) | Resident ($6,700) | Doctor ($11,300) | Specialist ($17,000) / Surgeon ($24,000) |

#### Skill System

**Skill Level Requirements**:
- **Entry Level**: Skill Level 1
- **Career progression**: Varies by role (Level 2-12 for top positions)
- **Life Goal Achievement**: Career goal requires Skill Level 12

**Experience Gain Methods**:
1. **Passive XP**: 500 XP per round (automatic)
2. **Education Investment**: Formal degree programs
3. **Budget Allocation**: Self-improvement budget category
4. **Online Learning**: Cost-effective skill development

**Skill Calculation**:
```dart
experiencePerDollar = 300 XP per $1,000 spent on self-improvement
```

#### Salary & Benefits

**Salary Crediting**:
- Applied at the end of each round for employed players
- 80% to unbudgeted savings (requires budgeting allocation)
- 20% to CPF account (automatic)

**Career Change**: Players can switch career paths at any time, subject to skill level requirements

---

### 🏪 Business Management

The business management system allows players to create and manage businesses across 5 sectors, with realistic competition dynamics and growth mechanics.

#### Business Sectors

| Sector | Base Revenue | Initial Cost Factor | ESG Potential |
|--------|--------------|---------------------|---------------|
| **Social Media** | $5,000 | 1.6× | 0-10 |
| **F&B** | $8,000 | 1.6× | 0-35 |
| **E-commerce** | $10,000 | 1.6× | 0-5 |
| **Technology** | $13,000 | 1.6× | 15-30 |
| **Pharmaceutical** | $18,000 | 1.6× | 10-25 |

#### Business Economics

**Initial Cost Calculation**:
```
Cost = Base Revenue × 1.6 × (1 + Pioneer Penalty + ESG Bonus + Economic Factors + Random Factor)
```

**Cost Modifiers**:
- **Pioneer Penalty**: +10% for first business in sector
- **Saturation Discount**: -10% when 3+ businesses exist
- **Depression Discount**: -15% during economic depression
- **ESG Bonus**: Up to +30% for high sustainability ratings
- **Random Factor**: ±10% variation

#### Revenue & Growth Dynamics

**Revenue Calculation**:
```
Revenue = Base Revenue × Growth Multiplier × (1 + ESG Bonus + World Event + Economic Cycle + Random)
```

**Competition Effects (Growth Multiplier)**:
- **Monopoly** (1 business): 25% growth per round
- **Oligopoly** (2-3 businesses): 15% growth per round  
- **Perfect Competition** (4+ businesses): 0% growth per round
- **Market Saturation** (no growth opportunities): 2% growth per round

**Growth Opportunities**: Each business has 4 growth opportunities before reaching market maturity

#### Research & Development (R&D)

**R&D Mechanics**:
- **Cost**: 55% of current revenue
- **Success Rate**: 60%
- **Growth Benefit**: 30% permanent revenue increase
- **Limitation**: Once per round per business
- **Failure**: Investment lost, no revenue growth

**R&D Decision Matrix**:
```
Expected Value = (Success Rate × Growth Benefit) - Cost
Expected Value = (0.6 × 0.3 × Revenue) - (0.55 × Revenue)
Expected Value = -0.37 × Revenue (slightly negative)
```

*Strategic Note: R&D becomes profitable when considering long-term compounding effects*

#### Business Valuation

**Valuation Formula**:
```
Valuation = Revenue × 1.25 × (1 + ESG Bonus + World Event + Economic Cycle - Competitor Penalty)
```

**Valuation Factors**:
- **ESG Bonus**: Up to +30% for sustainable practices
- **Competitor Penalty**: -5% per competitor in sector
- **Revenue Multiplier**: 1.25× base adjustment for future earnings potential

#### Business Financing

**Business Loans**:
- **No upfront requirements**: Unlike asset loans
- **Profit-First Repayment**: Business profits automatically repay debt
- **Loss Accumulation**: Business losses add to debt principal
- **No Interest**: Business loans don't accrue interest

---

### 🏠 Asset Management

Players can invest in appreciating assets that provide utility benefits and contribute to final wealth calculation.

#### Real Estate Investment

**Property Types**:

| Property | Base Cost | Marriage Requirement | Appreciation |
|----------|-----------|---------------------|--------------|
| **HDB Flat** | Variable | Yes | Market-based |
| **Condominium** | Variable | No | Market-based |
| **Bungalow** | Variable | No | Market-based |

**Real Estate Mechanics**:
- **Appreciation**: All properties appreciate in value each round
- **Mortgage Options**: Available through asset loan system
- **Selling**: Properties can be sold during player's turn
- **Utility**: Provides happiness and ESG benefits

#### Vehicle Investment

**Car Types**:

| Vehicle Type | ESG Rating | Happiness Bonus | Price Range |
|--------------|------------|-----------------|-------------|
| **Petrol Car** | Low | Standard | Budget-friendly |
| **Hybrid Car** | Medium | Enhanced | Mid-range |
| **Electric Car** | High | Maximum | Premium |

**Vehicle Mechanics**:
- **Certificate of Entitlement (COE)**: Required for all vehicles
- **COE Price Inflation**: Increases with each vehicle purchase by any player
- **Depreciation**: Cars lose value each round
- **Loan Options**: Available through asset loan system
- **Environmental Impact**: Electric vehicles provide maximum ESG benefits

#### Asset Loan System

**Loan Requirements**:
- **Debt Service Ratio**: Total loan repayments cannot exceed 70% of salary
- **Repayment Source**: Automatic deduction from Savings Account
- **Default Handling**: Delayed to next round if insufficient funds

**Loan Calculation**:
```
maxMonthlyPayment = salary × 0.70
maxLoanAmount = maxMonthlyPayment × loanTerm × interestAdjustment
```

---

### 📊 Budgeting System

The budgeting system requires players to allocate income across five essential categories, simulating real-world financial planning.

#### Budget Categories

| Category | Priority | Minimum | Effect | Calculation |
|----------|----------|---------|--------|-------------|
| **Daily Expenses** | 5 (Highest) | >0% | Survival requirement | Must be allocated |
| **Self Improvement** | 4 | 0% | Skill XP gain | 300 XP per $1K spent |
| **Recreational** | 3 | 0% | Happiness boost | 2 happiness per 10% |
| **Investment** | 2 | 0% | Investment account | Direct transfer |
| **Savings** | 1 (Lowest) | 0% | Savings account | Direct transfer |

#### Budgeting Mechanics

**Allocation Rules**:
- Total allocation must equal 100% (10 units)
- Daily Expenses must be > 0% (survival requirement)
- System auto-adjusts lower priority categories when limits exceeded

**Budget Application**:
```dart
// Self-improvement to skill XP
int exp = (totalBudget × selfImprovementPercent / 10) / 1000 × 300

// Recreation to happiness  
int happiness = recreationalPercent × 2

// Financial transfers
savingsTransfer = totalBudget × savingsPercent / 10
investmentTransfer = totalBudget × investmentPercent / 10
```

**Strategic Considerations**:
- **Early Game**: Focus on self-improvement and savings accumulation
- **Mid Game**: Balance investment allocation with happiness maintenance  
- **Late Game**: Maximize investment allocation for compound growth

---

### 🌱 ESG Integration

Environmental, Social, and Governance (ESG) factors are deeply integrated throughout the game, reflecting real-world sustainable finance trends.

#### ESG Scoring System

**ESG Point Sources**:
- **Stock Investments**: Points awarded for first-time ESG stock purchases
- **Business Ownership**: Points equal to business ESG rating
- **Vehicle Choices**: Electric > Hybrid > Petrol
- **Investment Strategy**: Long-term ESG holdings vs. short-term speculation

#### ESG Benefits

**Stock Market**:
- **Stability**: ESG stocks have lower volatility
- **Long-term Growth**: Better performance during economic recovery
- **Market Resilience**: Less affected by negative world events

**Business Operations**:
- **Revenue Bonus**: Up to +20% revenue for high ESG businesses
- **Valuation Premium**: Up to +30% higher business valuations
- **Customer Loyalty**: Reduced impact from competition

**Final Scoring**:
- **Team ESG Bonus**: 10% final score bonus if team average ESG > 80
- **Individual Recognition**: ESG contributions tracked on leaderboard
- **Sustainable Victory**: ESG factor influences winner determination

#### ESG Strategy Guide

**Maximum ESG Approach**:
1. Purchase all available ESG stocks
2. Create high ESG-rated businesses
3. Choose electric vehicles
4. Maintain long-term ESG investments

**Balanced ESG Approach**:
1. Select highest-yielding ESG stocks
2. Balance ESG ratings with profitability
3. Consider hybrid vehicle options
4. Strategic ESG timing for market conditions

---

### 🔄 Economic Cycles

The game simulates realistic economic fluctuations through a 4-phase economic cycle that affects all financial systems.

#### Economic Phases

| Phase | Description | Duration | Market Effect | Business Impact |
|-------|-------------|----------|---------------|-----------------|
| **Recession** | Economic downturn | Variable | Neutral sentiment | -10% earnings |
| **Depression** | Severe contraction | Variable | -50% sentiment | -20% earnings |
| **Recovery** | Economic improvement | Variable | +50% sentiment | No change |
| **Boom** | Economic prosperity | Variable | +100% sentiment | +25% earnings |

#### Economic Cycle Effects

**Stock Market Impact**:
```dart
// Market sentiment multiplier applied to all stocks
depression: -0.5    // Severe bear market
recession: 0.0      // Neutral market  
recovery: +0.5      // Moderate bull market
boom: +1.0          // Strong bull market
```

**Business Revenue Multipliers**:
```dart
// Applied to all business earnings calculations
depression: -0.20   // Severe business contraction
recession: -0.10    // Mild business decline
recovery: 0.00      // Neutral business conditions  
boom: +0.25         // Strong business growth
```

**Asset Pricing**:
- **Real Estate**: Prices affected by economic cycle multipliers
- **Vehicles**: Depression provides discount opportunities
- **Business Costs**: Depression offers 15% business acquisition discounts

#### Economic Strategy

**Recession/Depression Strategy**:
- **Defensive Positioning**: Focus on stable investments and cash reserves
- **Opportunity Identification**: Acquire undervalued assets and businesses
- **Risk Management**: Reduce leverage and maintain liquidity

**Recovery/Boom Strategy**:
- **Growth Investments**: Increase stock market and business exposure
- **Leverage Utilization**: Strategic use of loans for asset acquisition
- **Expansion Focus**: Scale business operations and investment portfolios

---

### 🌍 World Events

Random world events create dynamic market conditions, affecting specific business sectors and adding unpredictability to the game.

#### World Event Mechanics

**Event Characteristics**:
- **Duration**: 2 rounds or until next world event triggers
- **Sector Targeting**: Events affect 1-2 specific business sectors
- **Market Impact**: ±100% sector trend influence
- **Randomization**: Events triggered by landing on World Event tiles

**Event Types**:
1. **Positive Events**: Boost affected sector performance
2. **Negative Events**: Reduce affected sector performance  
3. **Neutral Events**: Provide information without direct impact

#### Sector Impact Examples

**Technology Boom** (Positive):
- Technology stocks: +100% sector trend
- Technology businesses: +30% revenue multiplier
- Duration: 2 rounds

**Food Safety Crisis** (Negative):
- F&B stocks: -100% sector trend  
- F&B businesses: -20% revenue multiplier
- Duration: Until next event

**E-commerce Regulation** (Negative):
- E-commerce stocks: -100% sector trend
- E-commerce businesses: -20% revenue multiplier
- Affects both stocks and businesses simultaneously

#### Strategic Considerations

**Event Preparation**:
- **Diversification**: Spread investments across multiple sectors
- **Timing**: Consider selling before negative events, buying during positive events
- **Business Portfolio**: Balance business sectors to reduce event risk

**Event Response**:
- **Quick Adaptation**: Adjust investment strategy based on current events
- **Opportunity Capture**: Increase exposure to positively affected sectors
- **Risk Mitigation**: Reduce exposure to negatively affected sectors

---

### 👥 Personal Life Progression

The personal life system adds a human element to financial decision-making, requiring players to balance wealth accumulation with life satisfaction.

#### Life Stages

| Stage | Requirements | Benefits | Costs |
|-------|--------------|----------|--------|
| **Single** | Default state | Flexibility | Limited real estate options |
| **Dating** | Payment decision | Happiness boost | Ongoing expenses |
| **Married** | Progressive cost | HDB access | Ceremony expenses |
| **Family** | Significant investment | Maximum happiness | Childcare costs |

#### Life Stage Mechanics

**Progression Costs**:
- **Dating**: Optional investment in relationship
- **Marriage**: Substantial one-time cost
- **Family**: Major ongoing financial commitment

**Happiness Impact**:
- Each life stage progression increases happiness
- Family stage provides maximum happiness multiplier
- Life satisfaction affects final score calculation

**Real Estate Access**:
- **HDB Eligibility**: Marriage required for public housing
- **Priority Benefits**: Family status may provide housing advantages
- **Investment Strategy**: Life stage influences optimal asset allocation

#### Life Goal Integration

**Family Life Goal**:
- **Target**: Achieve Family stage in Personal Life
- **Bonus**: 20% final score multiplier if achieved
- **Strategy**: Balance family investment with wealth accumulation

---

### 🎓 Education System

The education system provides multiple pathways for skill development, representing formal and informal learning opportunities.

#### Education Options

| Option | XP Gain | Cost | Time | Benefits |
|--------|---------|------|------|----------|
| **Diploma** | High | Medium | Multi-round | Career progression |
| **Bachelor's** | Higher | High | Multi-round | Advanced careers |
| **Master's** | Highest | Highest | Multi-round | Leadership roles |
| **PhD** | Maximum | Maximum | Multi-round | Expertise recognition |
| **Online Learning** | Moderate | Low | Single round | Cost-effective |
| **Skip Education** | None | None | Immediate | Focus on other areas |

#### Education Mechanics

**Formal Education Progression**:
1. **Sequential Requirements**: Must complete lower degrees first
2. **Cost Scaling**: Each degree level costs significantly more
3. **XP Scaling**: Higher degrees provide exponentially more experience
4. **Career Gates**: Advanced positions require specific education levels

**Alternative Learning**:
- **Budget Allocation**: Self-improvement budget category
- **Passive XP**: 500 XP automatic gain per round
- **Online Courses**: Moderate XP gain at lower cost

#### Education Strategy

**Early Investment Strategy**:
- Pursue formal education for long-term career benefits
- Accept short-term opportunity costs for higher lifetime earnings
- Focus on degrees required for target career path

**Practical Learning Strategy**:
- Utilize budget allocation for consistent skill growth
- Combine online learning with practical experience
- Balance education costs with immediate financial needs

---

### 💸 Loans and Debt

The loan system provides financing options for major purchases while introducing realistic debt management challenges.

#### Loan Types

**Asset Loans**:
- **Purpose**: Real estate and vehicle purchases
- **Requirement**: Debt service ratio ≤ 70% of salary
- **Repayment**: Automatic from Savings Account
- **Interest**: Applied according to loan terms
- **Default**: Delayed payment if insufficient funds

**Business Loans**:
- **Purpose**: Business acquisition and operations
- **Requirement**: None (high accessibility)
- **Repayment**: Profit-first from business earnings
- **Loss Handling**: Losses added to principal debt
- **Interest**: No interest charges

#### Debt Management Mechanics

**Asset Loan Calculation**:
```dart
maxMonthlyPayment = salary × 0.70
availableLoanCapacity = maxMonthlyPayment - currentLoanPayments
```

**Business Debt Dynamics**:
```dart
// Profitable business
netEarnings = businessEarnings - debtRepayment

// Unprofitable business  
totalDebt = previousDebt + businessLosses
```

#### Debt Impact on Scoring

**Debt Penalty Structure**:
- **≤10% Debt-to-Asset Ratio**: No penalty
- **11-25% DAR**: 5% score penalty
- **26-50% DAR**: 15% score penalty
- **51-75% DAR**: 25% score penalty
- **76-90% DAR**: 50% score penalty
- **≥90% DAR**: 80% score penalty

**Strategic Debt Management**:
- Maintain debt-to-asset ratio below 10% for optimal scoring
- Use business loans strategically (no interest charges)
- Consider debt payoff timing before game end
- Balance leverage benefits against penalty risks

---

### 🏆 Scoring Formula

The game employs a comprehensive scoring system that balances multiple financial and life success factors.

#### Final Score Calculation

```
Final Score = (Total Assets × Happiness Factor) - Debt Penalty + Life Goal Bonus + ESG Team Bonus
```

#### Scoring Components

**Total Assets** = Accounts + Portfolio + Business Valuation + Real Estate + Vehicles
```dart
totalAssets = savingsBalance + cpfBalance + investmentBalance + 
              portfolioValue + businessValuation + realEstateValue + vehicleValue
```

**Happiness Factor** = `max(1, happiness - 100 + 1)`
- Base happiness: 100
- Each happiness point above 100 adds to multiplier
- Minimum multiplier: 1 (no penalty below base happiness)

**Debt Penalty** (Applied to final score):
- **0-10% DAR**: No penalty (×1.00)
- **11-25% DAR**: 5% penalty (×0.95)
- **26-50% DAR**: 15% penalty (×0.85)
- **51-75% DAR**: 25% penalty (×0.75)
- **76-90% DAR**: 50% penalty (×0.50)
- **90%+ DAR**: 80% penalty (×0.20)

**Life Goal Bonus**: 20% bonus (×1.20) if achieved
- **Wealth Goal**: ≥$300k total assets
- **Career Goal**: Skill Level 12
- **Family Goal**: Achieve Family life stage

**ESG Team Bonus**: 10% bonus (×1.10) if team average ESG > 80 per player

#### Winning Strategy

**Balanced Approach**:
1. **Asset Accumulation**: Focus on appreciating investments
2. **Happiness Maintenance**: Balance wealth with life satisfaction  
3. **Debt Management**: Keep debt-to-asset ratio below 10%
4. **Life Goal Achievement**: Target specific goal for 20% bonus
5. **ESG Contribution**: Contribute to team ESG for 10% bonus

**Optimal Score Formula Example**:
```
Example: $400k assets × 1.5 happiness × 1.0 debt × 1.2 life goal × 1.1 ESG
Final Score = 400,000 × 1.5 × 1.2 × 1.1 = 792,000 points
```

---

## 📖 Game Rules

### Victory Conditions

Players compete to achieve the highest final score through strategic financial management across multiple rounds. The game typically runs for 12-15 rounds, with each round consisting of player turns where participants:

1. **Roll dice** to move around the board
2. **Land on tiles** that trigger various game mechanics
3. **Make decisions** related to their financial situation
4. **Manage their turn** within the allocated time

### Turn Structure

**Each Round**:
1. **Economic Updates**: Economic cycle advancement, world event progression
2. **Market Updates**: Stock prices updated, interest credited to all accounts
3. **Income Distribution**: Salaries credited, business earnings distributed
4. **Player Turns**: Individual players take turns in sequence

**Each Turn**:
1. **Dice Roll**: Player moves around the board
2. **Tile Effect**: Execute action based on landing position
3. **Decision Making**: Player makes strategic choices
4. **Turn Completion**: Next player begins their turn

### Game End Conditions

The game ends when:
- **Target Rounds Completed**: Typically 12-15 rounds
- **Facilitator Decision**: Based on time constraints or educational objectives
- **Player Elimination**: In extreme debt situations (rare)

### Winning Determination

1. **Score Calculation**: Final scores computed using the comprehensive formula
2. **Leaderboard Generation**: Players ranked by final score
3. **Winner Declaration**: Highest scoring player wins
4. **Category Recognition**: Additional recognition for ESG leadership, innovation, etc.

---

## 📱 Installation & Setup

### Prerequisites

- **macOS**: Required for iOS development
- **Xcode**: Latest version for iOS compilation
- **Flutter**: Version compatible with Dart SDK >=3.3.1 <4.0.0
- **iOS Simulator or Device**: For testing and gameplay

### Installation Steps

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd alpha
   ```

2. **Install Flutter dependencies**:
   ```bash
   flutter pub get
   ```

3. **iOS Setup**:
   ```bash
   cd ios
   pod install
   cd ..
   ```

4. **Run the application**:
   ```bash
   flutter run
   ```

### Development Setup

**Recommended IDE**: VS Code or Android Studio with Flutter extensions

**Key Commands**:
- `flutter analyze`: Code analysis and linting
- `flutter test`: Run unit tests
- `flutter build ios`: Build for iOS distribution

---

## 🤝 Contributing

We welcome contributions to improve the Alpha Cashflow Game! Whether you're fixing bugs, adding features, or enhancing documentation, your help is appreciated.

### Development Guidelines

1. **Follow Flutter Best Practices**: Adhere to Dart and Flutter conventions
2. **Maintain Game Balance**: Consider impact on gameplay when making changes
3. **Test Thoroughly**: Ensure changes don't break existing functionality
4. **Document Changes**: Update README and code comments as needed

### Areas for Contribution

- **Game Balance**: Fine-tuning economic formulas and game mechanics
- **UI/UX Improvements**: Enhancing user interface and experience
- **Performance Optimization**: Improving app performance and responsiveness
- **Educational Content**: Adding tutorials, help systems, or explanatory content
- **Analytics**: Adding gameplay analytics and learning assessment tools

### Reporting Issues

Please report bugs and feature requests through the project's issue tracking system, including:
- Detailed description of the issue
- Steps to reproduce
- Expected vs. actual behavior
- Screenshots if applicable

---

## 📄 License

This project is developed by the NTU Investment Interactive Club (IIC) for educational purposes. All rights reserved.

**Educational Use**: This application is designed for financial literacy education and should be used in accordance with educational objectives.

**Commercial Use**: Commercial use or distribution requires explicit permission from NTU Investment Interactive Club.

---

<div align="center">
  
**Developed with ❤️ by NTU Investment Interactive Club**

*Empowering the next generation of financially literate individuals through innovative gamification*

Version 0.4.1 Build 4 | © 2025 NTU Investment Interactive Club

</div>