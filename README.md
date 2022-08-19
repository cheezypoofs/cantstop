# Can't Stop: A godot experiment

Like many home projects, this was an excuse to learn a new thing. In this case, [godot](https://godotengine.org/). [Can't Stop](https://en.wikipedia.org/wiki/Can't_Stop_(board_game)) is a game my family grew up playing. I have no intentions of making money on this project so I hope you will see the possible infrigement on the trademark'd game as a complement more than anything :) When learning a new tech, sometimes it is best to use a domain you already know well and this game is obscure enough it's kinda novel.

## Dependencies

[godot](https://godotengine.org/article/dev-snapshot-godot-4-0-alpha-14): 4.0.alpha.14

## Things I learned (or think I learned)

- Call me old; I like [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller). For now, I'm working hard to separate models into `./models` and leaving the view and controller logic coupled together in `./scenes`. I think my goal to make a CPU player will benefit from having everything logic'y in there.
- For now, I don't think it's so bad to have the scene `.tscn` and `.gd` together. Online tutorials putting all gd's in `./scripts` feels silly to me.
- I'm pretty sure I'll want minimal testing soon, esp for the models and event stuff.
- It seems you _can_ make inner classes, which feels like an easy way to get struct-like behavior, but turns out it's annoying. The editor gets confused, the type system doesn't love it, and in fact runtime type checks don't seem to work. Just create `./models` and do something like:

```gdscript
extends Object
class_name Thing
```

## Plans

- Learn to suck less at the UI design
- Show possible moves when selected on the board and dice. This will help teach the game.
- Allow player(s) to be added. Home screen, etc.
- Build CPU players. I want to even pit CPU v CPU with different settings to exercise it.
- Network play with another local device?
