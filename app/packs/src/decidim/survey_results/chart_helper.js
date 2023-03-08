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

export function generateDatasets(data) {
  let datasets = [];

  let labels = data.first
  console.log(data[0])
  console.log("primer data")
  data.forEach((data, index) => {
    console.log("DATA")
    console.log(data)
    let dataset = {
      label: "perico",
      data: data[0][index],
      backgroundColor: dynamicColor(),
      borderWidth: 1,
    }

    console.log(data)

    datasets.push(dataset);
  });

  return datasets;
}
     // datasets: [
      //   {
      //     label: 'Cine',
      //     data: [1,2],
      //     backgroundColor: dynamicColor(),
      //     borderWidth: 1,
      //   },
      //   {
      //     label: 'Musica',
      //     data: [0,4],
      //     backgroundColor: dynamicColor(),
      //     borderWidth: 1,
      //   },
      //   {
      //     label: 'Deporte',
      //     data: [0,6],
      //     backgroundColor: dynamicColor(),
      //     borderWidth: 1,
      //   },
      // ]
      