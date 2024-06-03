# todos_app

This project was created to showcase a small app that allows the user to track their TODOs. It also allows them to create a new TODO.

> **_⚠️WARNING:_**  Creating a todo has been set to fail/succeed with a random 50/50 chance, so if ypu keep getting an error, it means you're unlucky 😜

## Purpose
The purpose of the app was to display a nice code architecture and my overall preferred tech stack and coding style.

The project integrates a demo API of to TODOs which is limited, therefore all features are quite limited because of the demo API and the demonstration purposes of the project.

## How to run
I suggest using FVM to run the app using Flutter 3.22.0 for the best experience.

## Challenges
Here are some parts of the project that were more tricky and were build intentionally to showcase some skill:
- the custom text field that has a custom error message
- the vertical divider next to each task required an IntrinsicHeight Widget as parent to make it have the same height as the TODOs title
- changing the checkbox on the left to a loading indicator and back required some extra fiddleing with the BLoC state management especially since the app fetched the entire list of TODOs from the API at once

## Can't build the project?
If you don't have the environment to run the code, here is a video and some screenshots of what it looks like:

### Video


### Screenshots
