# StreamNow

Demo iOS app project for [Streamlabs Mobile App Assignment](https://github.com/stream-labs/mobile-assignment) by Maxim Khatskevich.



## Overview

The app consists of 2 screens - "Feed" and "Profile", which are embedded into a tab bar view.



## Dependencies

The app is built with latest SDK (iOS 15) using Xcode 13.0. It depends on Combine and SwiftUI, plus with few  other frameworks which I use whenever I have a chance:

- [XCEssentials/Pipeline](https://github.com/XCEssentials/Pipeline) that enables elegant chain expressions to avoid temporary variables and reverse the order of expression via few custom operators;
- [XCEssentials/UniFlow](https://github.com/XCEssentials/UniFlow) that allows to express app functionality through [unidirectional data flow](https://redux.js.org/tutorials/fundamentals/part-2-concepts-data-flow) and [finite state machine](https://en.wikipedia.org/wiki/Finite-state_machine) concepts, which matches seemlessly the concepts that SwiftUI is built upon.



## Project structure

Whole project types/files are split into 3 major groups - Services, Features and Views.

### Services

Service meant to be an abstraction over an external resource, such as external memory, remote/network resource, hardware, etc. Typical basic example is a backend API wrapper. A service is defined by a protocol and typically expected to have at least "real" implementaiton for production/release use and, often times, a mock one for all kinds of testing/staging purposes.

### Features

Features are the backbone of the app, it's business logic, what the app can do. They suppose to be fully agnostic from either external dependencies or GUI. Expressed with use of [XCEssentials/UniFlow](https://github.com/XCEssentials/UniFlow) concepts. Each **feature** can only be present in **state storage** in one and only one **state** at any given time. **Actions** implement actual business logic.

### View

Views are presented by SwiftUI views and view models. Each screen/view has it's own dedicated view model, which in tern helps view to interact with state storage.



## Uni-directional data flow

Unidirectional data flow concept in this specific project is implemented as follows.

1. **Actions** (defined in **features** as static functions) can be sent from anywhere into **state storage** for **dispatcher** to process.
2. Every time an action causes mutation in **dispatcher.state** - mutation **notifications** are being dispatched to any **observers** who **subscribed** for updates.
3. Observers (in our case **view models**) must explicitly subscribe and then observe notificatsions throught **bindings**.
4. Whenever an event happens in GUI (view did appear on screen, user input, system notification, etc.) that requires a cahnge in app state - it must be translated into an **action** (defined in context of one of the features) and then **submitted** to **dispatcher** which in our case is incapsualted into **state storage** (a SwiftUI `ObservableObject`).
5. Each **action** then being **processed** in sequence on main thread by **dispatcher** and cicle repeats.

NOTE: each action is being executed in context of most recent copy of global app state and it's up to the action body if we are good to go or some preconditions are missing (we can indicate it by throwing an error), that means each action may be succesfully **processed**, or **rejected**.



## Why uni-directional data flow

* Unidirectional data flow allows to streamline and simplify data flows, makes it easy to reason about complex interactions and business logic, also helps with debugging.
* The whole web frontend world is basically dominated by frameworks built on this principle - Redux, React, etc.
* Lately even Apple themself came up wtih SwiftUI which is also based on unidirectional data flow concept.



## Why XCEUniFlow

[XCEssentials/UniFlow](https://github.com/XCEssentials/UniFlow) adds number of benefits on top of already brilliant unidirectional data flow.

* Makes the business logic code look more like declarative specifications rahter than traditional (imperative) software source code.
* Effortless built-in capabilities for logging, analytics tracking and debugging - both actions (processed and rejected) and state mutations.
* Elegantly solves the problem about sharing data across different scopes/screens - current state can be accessed from observers or from within other features, any action can be sent from anywhere - from observers, other actions or anywhere in the app.
* The one and the only dependency that you ever need to pass around is single reference to dispatcher (whcih is incapsualted in a state storage object in our case), which means no matter how deep your screen hiererchy is or how many features/functionality you have - it always gonna be just one value, which is in out case is propagated between screens through the use of `@EnvironemntObject` to make it even easier.
* it works seamlessly with SwiftUI, which covers the part about GUI development, while XCEUniFlow provides tools and methodology for implementing non-visual business logic, so it's a perfect match.



## Answers to your questions

- How long did it take you to complete this assignment?
  ***3-4 hours total of pure programming time, spread over 2 evenings***
- What about this assignment did you find most challenging?
  ***To decide whever I should use XCEUniFlow or come up with simpler rudimentary approach to not shock reviewer with too unconventional architecture/approach, but in the end decided to show it as I would actually do it for real production app in ideal situation where I can choose my archtiecture and choose my tools.***
- What about this assignment did you find unclear?
  ***Nothing, really. Really like the description, everything was clear and made sense right away. Very well done assignement that gives plenty of freedom for me to demonstrate my skills.*** 
- What challenges did you face that you did not expect?
  ***Didn't really have any challenges. I had clear idea of how to do the project beginnig to end right after I read the description, no major challneges. Just few little discoveries here and there cause I did not really play much with SwiftUI before and for UI was still using UIKit before. But now I see that, indeed, SwiftUI integrates neatly with XCEUniFlow just as I expected.***
- Do you feel like this assignment has an appropriate level of difficulty?
  ***Not at all. I think it is jsut right for a test assignemnt. It is not intended to take lots of time, but should provoke you to encounter enough typical development decisions making points so that you can see my choices and approach on how overall organize a typical project.***



## Notes on tests

No unit tests or UI tests are included to save time, since they were not required. Normally I'd write unit tests for key pieces of functionality like algorithms or data transformation, but with the technologies I use in the app they are unnecessary for the most part — SwiftUI is a very reliable and declarative way of building UI, data parsing is covered by strongly typed `Codable` protocol, and business logic is built with XCEUniFlow which guarantees a lot of stability and predictability through built-in checks of current state and preconditions any time we execute an action. I would, hoever, add some kind of UI or snapshot tests for individual screens to ensure integrety with desired designs (that we don't brae rendering as we change the code over time).