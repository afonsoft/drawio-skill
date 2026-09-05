# Observability and Instrumentation
A guide to building systems that are "operable" by ensuring production behavior is visible and diagnosable.

## 🎯 Purpose
Eliminate the "archaeology" phase of debugging. Instead of guessing what happened during a production crash, this skill ensures the system emits the right telemetry to answer "what is happening and why?" immediately.

## 🛠️ How it Works
The skill moves from "logging everything" to "answering specific questions":
1. **Define Questions**: Determine what an on-call engineer needs to know.
2. **Signal Selection**: Map questions to **Metrics** (that something is wrong), **Traces** (where it is wrong), and **Logs** (why it is wrong).
3. **Implementation**: Enforces structured logging (JSON), correlation IDs, and vendor-neutral OpenTelemetry standards.
4. **Symptom-Based Alerting**: Shifts alerts from causes (CPU high) to symptoms (Error rate > 1%).

## 🚀 Usage
Use this skill whenever you are implementing a new feature that will run in production, especially if it involves I/O, external APIs, or background jobs.

## 🔗 Correlation
- **Debugging**: This is the "preventative" side of debugging. Good observability makes debugging trivial.
- **Quality**: High-quality code (from `code-review-and-quality`) must include instrumentation as part of its "Correctness" axis.
