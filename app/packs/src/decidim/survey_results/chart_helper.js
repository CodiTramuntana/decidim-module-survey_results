export function dynamicColor() {
  let usedColors = new Set();
  let color = '#'+(Math.random() * 0xFFFFFF << 0).toString(16).padStart(6, '0');

  if (!usedColors.has(color)) {
    usedColors.add(color);
    return color;
  } else {
    return dynamicColors();
  }
};
