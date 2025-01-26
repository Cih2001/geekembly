---
title: The Spider web
date: 2025-01-26
description: Creating a spider web with p5js
toc: false
---

Here's the the algorithm behind spider's labour:

```js
// move to the center of the web
// translate(width / 2, height / 2);
let prevx = 0;
let prevy = 0;
let radious = 0;
for (i = 0; !done; i++) {
  angle += (2 * PI) / sides;
  x = radious * cos(angle);
  y = radious * sin(angle);
  line(prevx, prevy, x, y);
  radious += interval;
  prevx = x;
  prevy = y;
}
```

{{<spiderweb-01>}}
