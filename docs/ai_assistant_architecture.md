# AI Logistics Assistant Architecture

## Overview

The AI Logistics Assistant combines structured logistics data with unstructured logistics documents to answer business questions using two complementary approaches:

* **Text-to-SQL** for structured data
* **RAG (Retrieval-Augmented Generation)** for documents

```text
                 User
                  │
                  ▼
          Logistics AI Assistant
             /            \
            /              \
       Structured        Documents
          data             |
           ↓               ↓
       Text-to-SQL         RAG
            \              /
             \            /
              ▼          ▼
               Final answer
```

## 1. User

The user asks a logistics-related question using natural language.

Examples:

* "What is the late delivery rate by state?"
* "Which sellers have the highest delay rate?"
* "What does the carrier agreement say about delayed deliveries?"
* "Which states have the most delays and what does the carrier policy say about them?"

## 2. Structured Data

Structured logistics data is stored in analytical tables.

Examples:

* Orders
* Order items
* Customers
* Sellers
* Products
* Delivery performance

The data is prepared through the data platform and exposed through business-ready Gold tables.

## 3. Text-to-SQL

When the question requires numerical or structured information, the assistant translates the natural-language question into SQL.

```text
Natural-language question
          ↓
      Text-to-SQL
          ↓
       SQL query
          ↓
    Gold analytical table
          ↓
       SQL result
```

Examples:

* Late delivery rate
* Average delay
* Seller performance
* Regional performance
* Monthly trends

## 4. Documents

Unstructured logistics documents can include:

* Carrier agreements
* Supplier documents
* Contracts
* Incoterms
* Carrier tariffs
* Compliance declarations

These documents cannot be queried effectively using normal SQL.

## 5. RAG

RAG retrieves relevant information from the document collection before the language model generates an answer.

```text
User question
      ↓
Document retrieval
      ↓
Relevant document sections
      ↓
LLM
      ↓
Answer
```

## 6. Combined Answer

Some questions require both structured data and documents.

For example:

> "Which regions have the highest late-delivery rates, and what does the carrier agreement say about delayed shipments?"

The assistant can:

1. Query the structured logistics data using Text-to-SQL.
2. Retrieve relevant sections from the carrier agreement using RAG.
3. Combine the results.
4. Generate a natural-language response.

This creates a single interface for querying both logistics data and logistics documentation.

## Target Architecture

```text
                         ┌──────────────────┐
                         │       User       │
                         └────────┬─────────┘
                                  │
                                  ▼
                    ┌────────────────────────┐
                    │  Logistics AI Assistant │
                    └────────────┬───────────┘
                                 │
                     ┌───────────┴───────────┐
                     ▼                       ▼
              Structured Data            Documents
                     │                       │
                     ▼                       ▼
                Text-to-SQL                  RAG
                     │                       │
                     ▼                       ▼
                SQL Results           Retrieved Context
                     │                       │
                     └───────────┬───────────┘
                                 ▼
                       ┌──────────────────┐
                       │   LLM Response   │
                       └──────────────────┘
                                 │
                                 ▼
                       Final Business Answer
```

## Design Principle

The assistant separates **structured-data reasoning** from **document retrieval**.

* SQL provides quantitative answers from trusted analytical data.
* RAG provides contextual answers from logistics documents.
* The LLM acts as the conversational layer that brings the results together.
