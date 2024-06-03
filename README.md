# todos_app

This project was created to showcase a small app that allows the user to track their TODOs. It also allows them to create a new TODO.

> **_⚠️WARNING:_**  Creating a todo has been set to fail/succeed with a random 50/50 chance, so if you keep getting an error, it means you're unlucky 😜

## Features I've worked on:
For a detailed list of apps and features I've worked on, please check out my [LinkedIn](https://www.linkedin.com/in/madalin-broscareanu-62a7511a2/)

If you want to see more demo apps, then check out my [Bored App](https://github.com/FrogMustang/BoredApp) and my other demo repo (the code is a bit outdated for this one) - [Flutter Demo Apps](https://github.com/FrogMustang/flutter_demo_apps)


## Purpose
The purpose of the app was to display a nice code architecture and my overall preferred tech stack and coding style.

The project integrates a [demo API](https://jsonplaceholder.typicode.com/) of TODOs which is limited, therefore all features are quite limited because of the demo API and the demonstration purposes of the project.

## How to run
I suggest using [FVM](https://fvm.app/documentation/getting-started/installation) to run the app using Flutter 3.22.0 for the best experience.

## Challenges
Here are some parts of the project that were more tricky and were built intentionally to showcase some skill:
- the custom text field that has a custom error message
- the vertical divider next to each task required an IntrinsicHeight Widget as parent to make it have the same height as the TODOs title
- changing the checkbox on the left to a loading indicator and back required some extra fiddling with the BLoC state management especially since the app fetched the entire list of TODOs from the API at once

## Can't build the project?
If you don't have the environment to run the code, here is a video and some screenshots of what it looks like:

### Video
https://www.youtube.com/shorts/kv5gGe62ynw

### Screenshots
<img width=300 src="https://github.com/FrogMustang/TodosApp/assets/56998879/58eb1bd5-4865-4fff-9e33-003fa5074cf6"/>

<br/>

<img width=300 src="https://github.com/FrogMustang/TodosApp/assets/56998879/ea350118-3f32-4be7-a5f5-b063e2bcb247"/>
<img width=300 src="https://github.com/FrogMustang/TodosApp/assets/56998879/c2f36608-cdd3-4dea-80df-3cbda3b6b5dd"/>
<img width=300 src="https://github.com/FrogMustang/TodosApp/assets/56998879/b405adae-86ed-43e6-8793-d3dc4dbc8dac"/>


### Design inspiration
https://dribbble.com/shots/24240869-Todo-List-App


