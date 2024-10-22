# Ultimate Effects [Version 1.3]
The ultimate effects pack, made with :heart: over a *long* period of time. 
<br/>It contains text, font, and much more effects!
<br/>Contact Me: `@dystortedd` on Discord.

*For info in what you can do or not with this pack, read the MIT License*

# To-Do
- [X] Add Text Effects support in the wiki.
- [X] Add Font Effects support in the wiki.
- [X] Add leather shader effects.
- [ ] Add animated font support. <br/>In a long time because I would like to make 256x characters animations<br/>Will probably be a new function in the text effects.
- [ ] Add screen effects.

# Credits:
- Dragoncraft0000 (RP Contribution)
- thederdiscohund (Help with understanding shaders)
- Godlander       (Help with understanding shaders)

# How To Use

## Text Effects

> [!TIP]
> The config is located here:
> <br/>`[Pack Name]\assets\minecraft\shaders\include\configs\text.glsl`

To create an effect, add the code below. the (255, 0, 255) represents the color, e.g. `#FF00FF` in this case.
The function inside is going to tell the ressource pack what effect you want to give the specific color.

> [!TIP]
> A complete list of effects is available here:
> <br/>`[Pack Name]\assets\minecraft\shaders\include\effects\text.glsl`
> <br/>**Command Example:**
> <br/>`/title @a actionbar {"text":"Oh Wow, Rainbows !","color":"#ff00ff"}`

```
TEXT_EFFECT(255, 0, 255) {
	rainbow(1.0);
}
```


> [!WARNING]
> You can only choose colors that are with steps of 4.
> <br/>This is because the shadow calculation is `color / 4`, and the precision is divided by 4
> <br/>It is a Minecraft issue, meaning there is nothing I can do about it.

## Font Effects

> [!TIP]
> The config is located here:
> <br/>`[Pack Name]\assets\minecraft\shaders\include\configs\font.glsl`

This type of text effect is used for more global things that still need color hex support. Those font effects work with the text effects. 
<br/>This works by offsetting the text by chunks of -5000, which will give them 1 id per -5000 ascent.
This is used to anchor text to a position in the screen for example.

To create an effect, add the code below. the (1.0) represents the id, e.g. `ascent: -5000` in this case.
<br/>The function inside is going to tell the ressource pack what effect this specific font will have.

> [!TIP]
> A complete list of effects is available here:
> <br/>`[Pack Name]\assets\minecraft\shaders\include\effects\font.glsl`
> <br/>**Command Example:**
> <br/>`/title @a actionbar {"text":"Hello World Hello World","color":"#ff0000","font":"ult_effects:top_left_anchor"}`

```
FONT_EFFECT(1.0) {
	screen_anchor(-1.0, 2.0);
}
```


> [!CAUTION]
> Doesn't work on italic rext (seems hard to fix), 3D spaces (seems hard to fix)
> <br/>I will try to fix those issues one day.
> <br/>Also doesn't work on title shadow (seems hard to fix)

## Leather Effects

> [!TIP]
> The config is located here:
> <br/>`[Pack Name]\assets\minecraft\shaders\include\configs\leather.glsl`
> <br/>**Command Example:**
> <br/>`/give @p leather_chestplate[dyed_color=16712703] 1`

```
LEATHER_EFFECT(255, 0, 255) {
	leather.color.rgb *= animation(vec2(0, 0), 8.0, 1.0, 1000.0, true).rgb;
}
```


This effect replaces a hex color and transforms it. It can be whatever you want, from gradients, new colors, and even a completely new texture.
<br/>I made this obviously to rival Origin Realms' leather effects, which were pretty hype back then.

> [!TIP]
> A complete list of effects is available here:
> <br/>`[Pack Name]\assets\minecraft\shaders\include\effects\leather.glsl`
