# Ultimate Effects
The ultimate effects pack, made with :heart: over a *long* period of time. 
<br/>It contains text, font, and much more effects!
<br/>Contact Me: `@dystortedd` on Discord.

# To-Do
- [X] Add Text Effects support in the wiki.
- [X] Add Font Effects support in the wiki.
- [ ] Add animated font support.
- [ ] Add leather shader effects.
- [ ] Add screen effects.

# How To Use

## Text Effects

> [!TIP]
> The config is located here:
> <br/>`[Pack Name]\assets\minecraft\shaders\include\config\text_shaders_config.glsl`

To create an effect, add the code below. the (255, 0, 255) represents the color, e.g. `#FF00FF` in this case.
<br/>The function inside is going to tell the ressource pack what effect you want to give the specific color.

> [!TIP]
> A complete list of effects is available here:
> <br/>`[Pack Name]\assets\minecraft\shaders\include\effect\text_shaders.glsl`

```
TEXT_EFFECT(255, 0, 255) {
	applyRainbow(-1.0);
}
```


> [!WARNING]
> You can only choose colors that are 4 colors away from each other.
> <br/>This is because the shadow is `color / 4`, and the precision is divided by 4

## Font Effects

> [!TIP]
> The config is located here:
> <br/>`[Pack Name]\assets\minecraft\shaders\include\config\font_shaders_config.glsl`

This type of text effect is used for more global things that still need color hex support. Those font effects work with the text effects. 
<br/>This works by offsetting the text by chunks of -5000, which will give them 1 id per -5000 ascent.
This is used to anchor text to a position in the screen for example.

To create an effect, add the code below. the (1.0) represents the id, e.g. `ascent: -5000` in this case.
<br/>The function inside is going to tell the ressource pack what effect this specific font will have.

> [!TIP]
> A complete list of effects is available here:
> <br/>`[Pack Name]\assets\minecraft\shaders\include\effect\font_shaders.glsl`

```
FONT_EFFECT(1.0) {
	applyAnchor(-1.0, 2.0);
}
```
