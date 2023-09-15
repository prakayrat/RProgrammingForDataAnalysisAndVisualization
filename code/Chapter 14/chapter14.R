# Chapter 14
## Reading รูปภาพ
library(magick)
owl <- image_read("owl.png")
owl

owl <- image_resize(owl, "150x154")
print(owl)

## Rotating, flipping และ flopping
image_rotate(owl, 45)

image_flip(owl)

image_flop(owl)

## Annotating
image_annotate(owl, " i'm so cute", size=30, gravity="southwest",
               color="green")

image_annotate(owl, "> No.1 <", size=20, color="grey30",
               boxcolor="lightblue", degree=20, location="+40+70")

## Fill และ Border
image_fill(owl, "purple", "+50+50")

image_border(owl, "red", "25x5")

## Brightness, Saturation, Hue
image_modulate(owl, brightness = 90, saturation = 120, hue = 120)

## Filters และ Effects
image_blur(owl, 10, 8)

image_noise(owl)

image_charcoal(owl)

image_oilpaint(owl)

image_negate(owl)

## Layers
### 1)
owl_edi <- image_flop(owl)
owl_edi

owl_edi <-image_rotate(owl_edi, 180)
owl_edi

owl_edi <-image_background(owl_edi, "pink", flatten=T)
owl_edi

owl_edi <- image_border(owl_edi, "green", "5x10")
owl_edi

### 2)
owl_piped <- image_flop(owl) %>%
  image_rotate(180) %>%
  image_background("pink", flatten=T) %>%
  image_border("green", "5x10")
owl_piped

## รวมรูปภาพ
library(ggplot2)
ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Species)) +
  geom_point(size=4) +
  scale_color_manual(values=c("green", "brown", "pink")) +
  theme_bw()
ggsave("irisplot.png")

bg <- image_scale(image_read("irisplot.png"), "X350")
bg <- image_background(bg, "white")

owl_resize <- image_resize(owl, "80x")

image_composite(image=bg, composite_image= owl_resize, offset="+70+90")

## Animating
gyroscope <- image_read("Gyroscope_precession.gif")
gyroscope
rev(gyroscope)

## การทำ morphs
owl_shrinking <- image_morph(c(owl, owl_resize), frames=20)
image_animate(owl_shrinking, loop=10)


## Project: Combine และ animated รูปภาพ
### รวมภาพเคลื่อนไหวกับภาพนิ่ง
gyroscope <- image_read("Gyroscope_precession.gif")
gyroscope <- image_resize(image_read("Gyroscope_precession.gif"), "80x")
length(gyroscope)

bg <- image_scale(image_read("irisplot.png"), "x350")
bg <- image_background(bg, "white")

image_composite(image=bg, composite_image=gyroscope, offset="+200+220")
length(image_composite(image=bg, composite_image=gyroscope,
                       offset="+200+220"))

length(image_composite(image=bg, composite_image=gyroscope[1],
                       offset="+200+220"))

length(image_composite(image=bg, composite_image=gyroscope[30],
                       offset="+200+220"))


## image_apply()
lapply(iris, mean)

lapply(iris, function(x){mean(3*(x^2))})



gyroscope <- image_resize(image_read("Gyroscope_precession.gif"), "80x")

plot <- image_scale(image_read("irisplot.png"), "X350")

frame <- image_apply(image=gyroscope, function(frame) {
  image_composite(image=plot,
                  composite_image=frame, offset="+50+100")
})
length(frame)

print(frame)

## animation
animation <- image_animate(frame, fps=10)
print(animation)

## บันทึกไฟล์รูปภาพ
image_write(animation, "graph_ani.gif")
