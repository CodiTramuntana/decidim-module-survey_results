export function normalizeLabels(labels) {
  labels.forEach((label, index) => {
    if (label.length > 28) {
      let newLabel = splitLargeLabel(label);
      console.log(newLabel)
      labels[index] = newLabel
    }
  })

  return labels;
};

function splitLargeLabel(label) {
  let middle = Math.floor(label.length / 2);
  let before = label.lastIndexOf(' ', middle);
  let after = label.indexOf(' ', middle + 1);

  if (middle - before < after - middle) {
    middle = before;
  } else {
    middle = after;
  }

  return [label.substr(0, middle), label.substr(middle + 1)];
}
