# Ult-Effects
The ultimate effects pack. Text, Font, and much much more!
<br/>Made with :heart: by Dystortedd

# To-Do
- [ ] Add Font Effects support in the wiki.
- [ ] Start working on the leather shader effects.

# How To Use

## Text Effects

> [!TIP]
> The config is located here: `[Pack Name]\assets\minecraft\shaders\include\config\text_shaders_config.glsl`

To create an effect, add the code below. the (255, 0, 255) represents the color, e.g. `#FF00FF` in this case.
<br/>The function inside is going to tell the ressource pack what effect you want to give the specific color.

> [!TIP]
> A complete list of effects is available here: `[Pack Name]\assets\minecraft\shaders\include\effect\text_shaders.glsl`

```
TEXT_EFFECT(255, 0, 255) {
	applyRainbow(-1.0);
}
```


> [!WARNING]
> You can only choose colors that are 4 colors away from each other.
> <br/>This is because the shadow is `color / 4`, and the precision is divided by 4
