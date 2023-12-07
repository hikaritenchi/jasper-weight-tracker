# jasper_weight_tracker

A simple weight tracker that allows login through Firebase Auth (anonymous) and saves data in Cloud Firestore based on the user's UID.

## Tech Stack

This project uses a number of libraries:

State Management: Riverpod, Flutter Hooks
Date Formatting: intl

Riverpod was chosen as the state management solution as a way to practice using the library, as it is the preferred solution over Provider.

Flutter Hooks is also a way to avoid localized state management on the widget level (in place of StatefulWidget), and was also chosen for practice purposes.

## Remaining Bugs

I was able to have the list update in-place, but for some reason along the way, the sorting causes a "flash" where the list appears unsorted and then sorted.

When the user submits a weight, the form is cleared, but also causes the "Invalid Input" error message to appear.

## File organization

The file organization is mostly based on UI and UI components rather than separating out functionality.

In my experience, for smaller projects like this, it becomes quickly unwieldy to separate out data layers vs. screens, especially given the limitations.
For example, having only a single login function in an enclosing interface-like structure increases boilerplate while obfuscating functionality and increases the likelihood of confusion. 