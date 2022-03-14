![Frame 8](https://user-images.githubusercontent.com/19904063/158263872-2568afe3-fba3-4d6d-aaad-17eefe04822b.png)


## Inspiration
As kids, we loved puzzles, all kinds of puzzles. Our favourite one was [Rush Hour](https://en.wikipedia.org/wiki/Rush_Hour_(puzzle)), a slide puzzle that consisted of displacing cars to let a jammed vehicle drive through the exit. This was our inspiration. Our goal was to bring our favourite puzzle to Flutter; and we wanted this to be in three dimensions, just as how we played it.

## What it does
Our puzzle allows the player to play a daily Rush Hour game. They can drag and slide vehicles, which are projected to appear in three dimensions, in a 6x6 board. The board can be rotated to change the perspective and it can also be toggled to appear in two dimensions.

The player must move vehicles to free the ambulance. Whilst the user is playing the number of moved vehicles and time are tracked. Once completed, the puzzle animates and shows the player's score. They can share this with their friends, showing the sequence of vehicles they've moved (with matching vehicle emojis 🚕!).

> https://flutter-rush.web.app/  (#1)
>
> 10: 🚕🚌🚛🚛🚓🚌🚗🚌🚛🚐

![ZVehicle Example](https://raw.githubusercontent.com/alestiago/flutter_rush_puzzle/main/assets/shared/bus_rotation--example.gif)

## How we built it
The game is entirely built with Flutter!  Our secret sauce is [ZFlutter](https://pub.dev/packages/zflutter), which allowed us to bring a three-dimension illusion to our two-dimensional Flutter world!

## Challenges we ran into
One of the biggest breakthroughs the project went through was optimisation. More specifically, optimising [ZFlutter](https://pub.dev/packages/zflutter) code to avoid junk. The library has a variety of simple vector arithmetic and render objects and was too slow for our needs.  Moving to 4-dimension transformation matrixes allowed us to reach 60 fps. And we are talking about almost 6000 widgets built simultaneously inside a 200 depth tree!

## Accomplishments that we're proud of
We're proud of finishing the game altogether! Being able to experience our favourite childhood puzzle in Flutter was a satisfying experience. The fact that our game can be played in iOs, Android, Web and Windows blow our minds!

We're also glad that this project motivated us to improve the open-source package, [ZFlutter](https://pub.dev/packages/zflutter) and we will also be soon contributing with new open-source libraries to support the ecosystem. For example, we will be releasing a new library for building text components.

![ZCubicText Example](https://raw.githubusercontent.com/alestiago/flutter_rush_puzzle/main/assets/shared/z_cubic_text--example.gif)

## What we learned
Bringing a three-dimensional interface to flutter was not an easy task. We learnt throughout the process how to tackle the issues we faced with perspectives, drawing three-dimensional widgets and more!

This project allowed us to dive into exploring the possibilities of three dimensions in Flutter.

---

## Running the project

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Rush Hour Puzzle works on iOS, Android, Web, Windows and MacOs._

