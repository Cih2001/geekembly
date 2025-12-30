---
title: Polygon Spirals
date: 2025-12-29
description: Recursive Polygons
toc: false
math: true
---

I had a concept in mind about polygons repeating within each other infinitely. I call these spiral polygons. This is a made-up name; I don't know if these shapes are actually called this.

I took some time and implemented the idea below. The implementation is also explained afterward.

{{<polygons>}}

The idea is to create a new vertex along each edge of the polygon at a fixed distance, and create another polygon by connecting those. And doing that recursively.

Drawing the outer box(polygon) is easy. We just start from the starting point and the initial direction is pointing right. We continue along the direction for 10cm and then rotate the direction vector $ 90 \degree $. Doing the same operation 4 times, we will get the outer box.

<img src="/posts/img/polygons/poly0-dark.svg" alt="Polygon Spiral - outer box" class="theme-image-dark">
<img src="/posts/img/polygons/poly0-light.svg" alt="Polygon Spiral - outer box" class="theme-image-light">

For the inner polygons, first we have to move a bit further (decided by the interpolation factor) along the direction now.

<img src="/posts/img/polygons/poly1-dark.svg" alt="Polygon Spiral" class="theme-image-dark">
<img src="/posts/img/polygons/poly1-light.svg" alt="Polygon Spiral" class="theme-image-light">

In the above example, each side of the outer square is `10cm`, and we move `2cm` along each side. This means that our interpolation factor is `0.2`. So far so good. Now we have to draw a line from `A` to `B`. However, our algorithm does not work with absolute coordinates, but rather with relative coordinates. What we have to do, to be exact, is to start from point `A`, rotate $ \theta $ degrees, and draw a line with the length of $ |AB| $. Therefore, we have to calculate $ \theta $ and $ |AB| $. You might think this is easy, we can just apply the _Pythagorean Theorem_, but that only works if our polygon is a square. To calculate these values for generic polygons, it's best to consider a pentagon for our example.

<img src="/posts/img/polygons/poly2-dark.svg" alt="Polygon Spiral" class="theme-image-dark">
<img src="/posts/img/polygons/poly2-light.svg" alt="Polygon Spiral" class="theme-image-light">

Let's calculate the length of the new line to be drawn or $ |A^\prime B^\prime| $. From the _Law of Cosines_ we know:
$$ |A^\prime B^\prime| =\sqrt{|A^\prime B|^2 + |B B^\prime|^2 - 2 \times |A^\prime B||B B^\prime|cos(\alpha)}$$

$ \alpha $ is the interior angle of the polygon which is:

$$ \alpha = \frac{(n-2) \times \pi}{n} = 108\degree \text{ for } n = 5$$

Therefore,

$$ |A^\prime B^\prime| =\sqrt{8^2 + 2^2 - 2 \times 8 \times 2 cos(108\degree)}$$

To calculate $ \theta $ we can use the _Law of Sines_, which says:

$$ \frac{|B B^\prime|}{sin(\theta)} = \frac{|A^\prime B^\prime|}{sin(\alpha)}$$

And therefore,

$$ \theta = arcsin(\frac{|B B^\prime| \times sin(\alpha)}{|A^\prime B^\prime|}) = arcsin(\frac{2 \times sin(108\degree)}{|A^\prime B^\prime|}) $$

Where $|A^\prime B^\prime|$ is the length we calculated above. Voila! We can now draw the smaller polygon knowing how much we have to rotate ($\theta$) and the length of each side of it ($|A^\prime B^\prime|$). Doing this recursively, we will get a polygon spiral!

<style>
.theme-image-dark, .theme-image-light { 
  display: none;
  width: 75%;
  margin: 0 auto;
  display: block;
}
html.dark .theme-image-dark { display: block !important; }
html.dark .theme-image-light { display: none !important; }
html.light .theme-image-light { display: block !important; }
html.light .theme-image-dark { display: none !important; }
</style>
