---
title: Effective Practices for Architecting Web Applications
date: 2024-10-24
description: Resources for software architecuture
---

## Introduction

This post aims to provide resources I found valuable and introduce some of the best practices
I have discovered for architecting web applications. Although I primarily work with
the Go programming language, the concepts discussed here extend beyond any
specific language. These insights are applicable to various tech stacks with a focus on
building robust web applications.

It's important to note that there's no one-size-fits-all approach to software architecture.
The decisions you make should be tailored to the specific problem you are addressing,
as no single model is universally correct. Consider this document as a collection of
practices worth knowing or a reading list. Ultimately, it's up to you to decide - as a
architect - whether to apply them in your project or not.

## Documenting

### Docs As Code

Adopt the [Docs As Code](https://docsascode.org/) methodology to bring documentation close to your codebase.

- Store technical documentation in a `/doc` directory within your git repository to ensure developers can locate them easily.
- Documentation should be updated and published alongside code, allowing developers, and experts to collaborate within the same workflow.
- This also makes synchronizing documentation updates with code changes easier, maintaining consistency with new features or updates.

### Doc Comments

Golang has specific guidelines on doc comments, which can be found [here](https://go.dev/doc/comment).
However, this practice is not exclusive to Golang. Doc comments allow for automatic generation and
searching of package documentation using various tools. For further information, refer to `go help doc`.

### Automatic Doc Generation

Automate documentation generation from code and specifications.

- Create REST API documentation from specifications like [OpenAPI](https://swagger.io/specification/) and [Stoplight](https://stoplight.io/).
- Generate validation documentation if you're using JSON Schema. Take a look at tools like [JSON Schema for Humans](https://github.com/coveooss/json-schema-for-humans)

### Diagram As Code

Incorporate at least one diagram-as-code solution:

- [PlantUML](https://plantuml.com/) offers advanced capabilities but lacks native GitHub support.
- [Mermaid.js](https://mermaid.js.org/) has native support on GitHub.

### Architecture Decision Records

Document your architecture decisions using [Architecture Decision Records (ADRs)](https://github.com/joelparkerhenderson/architecture-decision-record).

### Engineering Design Document

Prepare an Engineering Design Document (EDD) prior to new feature development. This fosters team discussion on design and facilitates alignment on objectives and scope. Consider an EDD template tailored to your needs:

- Refer to [arc42](https://arc42.org/overview) for inspiration.
- Include sections like introduction, context, scope, requirements, assumptions, risks, and design.
- Utilize C4 Models for changes.
- Describe entity models and interfaces for additions.
- Detail changes in communication protocols (e.g., REST, Protobuf).
- Visualize request life cycles with sequence diagrams.

### C4 Models

Keep your [C4 Models](https://c4model.com/) up to date. Include context-relevant C4 models in EDDs as necessary.

### Entity Models

Consistently update entity model diagrams for each domain.

## Coding

### Coding Style

Choose a coding style and adhere to it consistently.

- This ensures code consistency and uniform appearance as if written by a single author.
- [Uber-Go](https://github.com/uber-go/guide/blob/master/style.md) is a famous style guide for Golang. Find a one for the programming language you're using and stick with it.

### Linters and Code Formatters

Configure linters and code formatters.

- This facilitates early error detection and helps prevent trivial disputes during code reviews.
  - For golang you can use [gofumpt](https://github.com/mvdan/gofumpt) and [golangci-lint](https://golangci-lint.run/).
  - [Prettier](https://prettier.io/) is also another formater that support a lot of languages/file formats.
- While I don't approve all clean code practices, some of them are useful and linters help enforce useful conventions.

### Precommit

With [pre-commit](https://pre-commit.com/), you can add Git hooks to perform checks before committing code
to the remote repository. While I am not particularly a fan of pre-commit—since
many of its functionalities can be effectively handled by a well-designed CI/CD
pipeline—it's worth mentioning for the sake of completeness in this blog.
It can be useful when combined with other tools, such as [gitleaks](https://github.com/gitleaks/gitleaks),
to enhance code quality and security.

## API Design First

Adopt an [API design-first approach](https://swagger.io/resources/articles/adopting-an-api-first-approach/).
This methodology emphasizes designing your API before writing any code, ensuring clearer structure and
communication from the outset. For REST APIs, you can follow Zalando's comprehensive
[API Guidelines](https://opensource.zalando.com/restful-api-guidelines/).

## Software Architecture

- **Hexagonal Architecture**: Implement [hexagonal architecture](https://alistair.cockburn.us/hexagonal-architecture/), which promotes a separation of concerns and enhances testability and maintainability by isolating the core application logic from technical details such as user interfaces and databases.

- **Composition Over Inheritance**: Favor composition over inheritance when structuring your code, and make use of dependency injection to manage dependencies explicitly and improve modularity.

- **Feature Toggles**: Explore the concept of [feature toggles](https://en.wikipedia.org/wiki/Feature_toggle) to enable or disable features:

  - **Global Toggles**: Manage features globally, activating or deactivating them for all users.
  - **Organizational Toggles**: Control features for specific subsets of users or organizations, which can be pivotal as you segment users in your software.
  - These toggles can also support monetization strategies by limiting feature access to paid users only.

- **Structured Logging**: Utilize [structured logging](https://betterstack.com/community/guides/logging/structured-logging/) to improve log interpretability and accessibility. Golang’s standard library offers support for structured logging, making it straightforward to incorporate.

- **Reusable Packages**: As you advance, consider developing generic packages for common needs such as:
  - Backoff retry mechanism
  - Circuit breaking patterns
  - In-memory caching

## Solution Architecture

### Domain-Driven Design

Grab a good domain driven design book and learn about it to gain a deep understanding of it.
I recommend reading [Implementing Domain-Driven Design](https://amzn.eu/d/8zgVKOK).
Achieving a solid design requires experience and practice. You're likely to make mistakes
and refine your models over time. Remember, there is no one "correct" model—some designs
are simply better suited than others. DDD guidelines have been shown to facilitate
adaptability and maintainability in software development.

### Modular Monolith

Never start with Micro-Services. Start with Modular Monoliths and refactor into macroservices.
A modular monolith differs from traditional monolithic architectures, where code is often organized by
technical layers such as MVC. In modular monoliths, domain-related code is grouped together,
enabling easier evolution into microservices when necessary.

Here are some insightful talks on modular monoliths:

- [Modular Monoliths • Simon Brown](https://youtu.be/5OjqD-ow8GE?si=jSXnavZIzXsG61RI)
- [The Modular Monolith - a Practical Alternative to Microservices by Victor Rentea](https://youtu.be/nuHMlA3iLjY?si=n1HneOhLz0cIfHuF)

### Event-Driven Design

Event-driven design plays a significant role in modern architectures.
It typically involves domains communicating with one another through domain events instead of synchronous calls.

Make sure to identify and avoid common antipatterns, such as:

- If your events resemble CRUD actions, it might indicate a design flaw.

For further insights, read these excellent articles: [The Entity Service Antipattern](https://www.michaelnygard.com/blog/2017/12/the-entity-service-antipattern/) and [Services By Lifecycle](https://www.michaelnygard.com/blog/2018/01/services-by-lifecycle/).

### Outbox Patterns

Familiarize yourself with the [Outbox Pattern](https://microservices.io/patterns/data/transactional-outbox.html).
It's a crucial in event-driven architectures.

### CQRS and Event Sourcing

Learn about [CQRS (Command Query Responsibility Segregation)](https://learn.microsoft.com/en-us/azure/architecture/patterns/cqrs) and [Event Sourcing](https://learn.microsoft.com/en-us/azure/architecture/patterns/event-sourcing).
Both concepts are integral for creating scalable and maintainable systems, especially in event-driven environments.

## Deployment

### CI/CD

Design a fully automated CI/CD pipeline that ensures code quality and smooth deployments.

- A model to follow is: lint -> test -> build -> deploy.
- Optionally, calculate test coverage: I suggest to reject code with less than 60% coverage and aim for 80%.

### Kubernetes

Screw [serverless](https://www.youtube.com/watch?v=qQk94CjRvIs) :joy:! Kubernetes 4ever! No more explaination needed!

### Deployment Environments

Create distinct deployment environments to isolate and test features effectively.

- **PR Environments**: Automatically create an environment for each pull request to isolate and test new features independently.
- **Staging Environment**: Run unreleased features in this environment. Developers should have full resource access for thorough testing. Populate with substantial data to conduct performance and manual tests.
- **Integration/Demo Environment**: Mimic the production environment to test releases and conduct product demos.
- **Production Environment**: The live environment for end-users.

The number of environments you choose depends on your needs and cost considerations.
One advantage of Kubernetes is the ability to efficiently manage multiple environments using Kubernetes namespaces.

### Infrastructure as Code

Use [Terraform](https://www.terraform.io/) to configure your infrastructure as code.
This helps you manage resources consistently and automate infrastructure changes.

### Branching Model

Adopt a branching model that best suits your team's workflow and stick with it.
[GitHub Flow](https://docs.github.com/en/get-started/using-github/github-flow) is a popular choice,
though you might consider [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/) as an alternative.

### Conventional Commits and Semmantic Versioning

Implement [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) and
[Semantic Versioning](https://semver.org/) to maintain clarity and consistency in your
commit messages and versioning, aiding in better project management and communication.

## Testing

### Unit Tests

Unit tests focus on testing individual components of your application with the help of mocks.

- **Mock Testing**:
  - Test your services by mocking repository calls to isolate the logic being tested.
  - Validate your adapters (e.g., REST, message brokers) using mock service calls to ensure they interact correctly with other components.
  - Similarly, test other adapters using mock service calls to check their functionality in isolation.
- **Automatic Mock Generation**: Use code generators to automatically create mocks from interfaces, which simplifies and speeds up the testing process.

### Integration Tests

Integration tests verify that different units work together with live systems or simulations of live systems.

- Test components against live databases, such as running queries against a Postgres instance.
- For cloud-based resources, conduct tests against real services in a PR environment or utilize tools like [moto](https://github.com/getmoto/moto) to simulate cloud service interactions.

### E2E Tests

End-to-end tests ensure the entire application works as expected in a real-world scenario.

- Deploy your application in a PR environment to replicate the user's context.
- For web applications, automate browser interactions using [Selenium](https://github.com/SeleniumHQ/docker-selenium). This involves writing tests to simulate user actions like button clicks and checking resulting HTML elements.
- For non-web applications (mobile or desktop), employ suitable automation tools to carry out similar user interaction checks.
- Optionally, incorporate [behavioral testing](https://cucumber.io/blog/bdd/the-ultimate-guide-to-bdd-test-automation-framewor/) to validate the application’s functionality through user stories and scenarios.

### Other Tests

While various other testing approaches exist, unit, integration, and end-to-end tests form the cornerstone of a reliable testing strategy for ensuring software quality across projects.

## Database Management

### Migrations

As your application evolves, so will your data models, necessitating the use of a migration tool
to manage schema changes effectively. [Migrate](https://github.com/golang-migrate/migrate) is a powerful tool for this purpose.
Other alternatives, like [Liquibase](https://docs.liquibase.com/workflows/liquibase-community/migrate-with-changetypes.html),
provide similar functionalities.

### Backup and Recovery

Your data is a critical asset. Implement automated regular backups or snapshots and establish
robust recovery mechanisms to safeguard against data loss. This ensures data integrity
and continuity in the event of unforeseen failures or incidents.

### Optimizations

As your database scales, consider implementing advanced optimization techniques to maintain performance and efficiency:

- **Query Optimizations**: Improve the execution speed of database queries through efficient query design and optimization practices.
- **Indexes**: Utilize indexes to speed up data retrieval operations, balancing the trade-offs between read and write performance.
- **Materialized Views**: Use materialized views to store complex query results, facilitating quick access to precomputed data.
- **Partitioning/Replication**: Employ partitioning to divide large tables into smaller, more manageable pieces, and leverage replication to increase data availability and redundancy.
- **Sharding**: Distribute data across multiple databases to balance load and enhance scalability, crucial for managing large-scale applications.

[Designing Data-Intesive Applications](https://amzn.eu/d/8TT3Ru7) is a wonderful book that explores the above concepts in details.

## Observability

Observability involves gathering and storing various types of telemetry data to gain
insights into your system's performance and behavior. Effective observability
solutions provide comprehensive monitoring and ensure your applications operate smoothly.

I particularly value the Grafana stack because it's opensource and works seamlessly with
[OpenTelemetry](https://opentelemetry.io/). However, many use a combination of different tools,
including offerings from cloud providers.

- **Logs**: Grafana's [Loki](https://grafana.com/docs/loki/latest/) is a popular choice for log storage and querying. Cloud providers like AWS, GCP, and Azure offer native logging solutions that are easy to set up and integrate into their ecosystems.
- **Traces**: While Grafana offers [Tempo](https://grafana.com/docs/tempo/latest/), alternatives like [Jaeger](https://www.jaegertracing.io/), or cloud-native tracing solutions can also be considered to monitor request flow and pinpoint bottlenecks.
- **Metrics**: [Prometheus](https://prometheus.io/) is the standard choice for collecting and querying time-series data, offering robust integrations and a wide range of features.
- **Profiles**: Profiling works exceptionally well with Golang, and Grafana's [Pyroscope](https://grafana.com/oss/pyroscope/) provides a solution for continuous profiling with minimal overhead. Profiling can even be left running in production environments due to its efficiency, as noted in [continuous profiling for Go](https://medium.com/@tvii/continuous-profiling-and-go-6c0ab4d2504b).

Investing in full observability stack components is costly upfront. Eerly you only need logging.
However, you consider integrating OpenTelemetry into your codebase early.
It'll make future observability expansions easier to implement.

### Dashboards

A key aspect of observability is displaying telemetry data through dashboards.
Grafana offers a powerful platform for creating dynamic and interactive
observability dashboards to visualize and analyze your system's performance metrics.

### Alerts

It's essential to set up alerts based on your telemetry data to act proactively. Consider scenarios like:

- Exceptionally long response times
- Latency or progress issues in consumer lags
- Frequent pod crashes or restarts
- Spike in 5xx status codes
- Sudden increases in 4xx status codes

You can setup alerts for all above cases using the telemetry data you're gathering.
Many teams use [Alertmanager](https://prometheus.io/docs/alerting/latest/alertmanager/)
as part of the Prometheus ecosystem, which integrates well with the Grafana stack.
Others opt for third-party alerting solutions like [PagerDuty](https://www.pagerduty.com/).

## Topics to Discuss with Engineers

Architecture is not solely about technical execution; it involves building strong
interpersonal relationships with your engineering team based on trust and knowledge sharing.
To create a collaborative environment, regularly engage with your team on design concepts and decisions.
Here are key topics to discuss to ensure everyone is aligned.

### Programming Language

Encourage discussions on the best practices for your chosen programming language.
Motivate engineers to delve into official documentation, blogs, and release notes after each update.
Talking a look at the standard library code is usually a good way of underestanding the language best practices.

For Golang enthusiasts, there are several standout resources:

- [Effective Go](https://go.dev/doc/effective_go)
- [Code Review Comments](https://go.dev/wiki/CodeReviewComments)
- [Go Proverbs](https://go-proverbs.github.io/)
- [Go Concurrency Patterns](https://www.youtube.com/watch?v=f6kdp27TYZs)

### Code Practices

Foster discussions around essential coding principles to ensure high-quality code and team alignment:

- **Minimal**:

  - Use the standard library whenever possible.
  - Abstract dependencies into interfaces wisely. However too much abstraction is bad. Each abstraction should serve a purpose and should be justifiable.
  - Strive minimal code while following the DRY (Don't Repeat Yourself) principle. Refactor code judiciously when it adds value.
  - Remember [Chesterton's Fence](https://www.nico.fyi/blog/chesterton-fence-programming): avoid removing or changing things until you understand why they're there.

- **Readable**:

  - [Avoid deep nesting](https://youtu.be/CFRhGnuXG-4?si=EQib6kZ3FlYi9EW2)
  - [Do not comment code unnecessarily](https://youtu.be/Bf7vDBBOBUA?si=ig7QUVas3h4caUXk)
  - Work on your [nameing](https://www.youtube.com/watch?v=-J3wNP6u5YU&t=201s)
  - If navigating a function requires much scrolling, consider this a signal for potential refactoring.
  - [Inheritance is bad!](https://youtu.be/hxGOiiR9ZKg?si=Kl36SYuOD7GrX2Lf)

- **Structured**:

  - Implement an API-first approach.
  - Pick a suitable project/directory layout, such as Golang's [standard project layout](https://github.com/golang-standards/project-layout).
  - Align on a consistent style guide and extend guidelines to cover error handling, structured logging, tracing, metrics, database transactions, retries, access control, authentication, and more.
  - [Commit Atomicly](https://www.aleksandrhovhannisyan.com/blog/atomic-git-commits/).

These practices are foundational for developing high-quality software and maintaining a coherent codebase over time.

### Pragmatic

Adopt a pragmatic coding philosophy:

- **YAGNI (You Aren't Gonna Need It)**: Code only for current needs, avoiding future assumptions.
- Dodge [premature optimizations](https://youtu.be/tKbV6BpH-C8?si=0lVUbGolCrcSKC4a)
- Code doesn't suddenly perform better because you thought so. It should be benchmarked.

### Architecture

Highlight the importance of a good design and architecture. If you are not taking care of architecture, it will take care of itself.
You won't end up with no architecture; you'll end up with accidental architecture.

### Security

Security should be an ongoing consideration, not an afterthought.
Equip engineers with the knowledge to write secure code, discussing:

- [SQL Injections](https://owasp.org/www-community/attacks/SQL_Injection)
- [Server-Side Request Forgery (SSRF)](https://cheatsheetseries.owasp.org/cheatsheets/Server_Side_Request_Forgery_Prevention_Cheat_Sheet.html)
- [Cross-Site Scripting (XSS)](https://owasp.org/www-community/attacks/xss/)
- Encourage familiarity with the [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- Inspire exploration of low-level programming languages like C/C++ for understanding the underlying workings of operating systems, memory management, etc.

### Reviewing Code

Discuss the best practices of the code review with the team.

- Prefer "Can we" and "Shouldn't we" over "Can you" and "You should."
- Focus on positives first; always begin with appreciation, thanking people for their time and contributions.
- Avoid nit-picking by leveraging linters; focus on core functionality correctness and adherence to guidelines.
- Recognize exceptions to rules after substantial peer discussion.
- Embrace new suggestions with openness.
- Devote time to understanding and appreciating colleagues' code.
- Aim for comprehensive reviews to minimize back-and-forth cycles.
- Prioritize reviews to assist colleagues in merging ready-to-ship code.

### Productivity Hacks

As programmers, efficiently managing and editing text is essential.

- Promote [touch typing](https://keybr.com) to increase typing efficiency.
- Encourage mastering the IDE for improved development experiences.
- Advise setting up CLI autocomplete features for tools like `kubectl`, `docker`, `gh`, `awscli`, which drastically improve productivity.
- Introduce valuable terminal applications, such as [tmux](https://github.com/tmux/tmux), [fzf](https://github.com/junegunn/fzf), [zoxide](https://github.com/ajeetdsouza/zoxide), [eza](https://github.com/eza-community/eza), [ripgrep](https://github.com/BurntSushi/ripgrep), [k9s](https://github.com/derailed/k9s).
