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

// data = [[0,1], [1,0]]
export function generateDatasets(labels, data) {
  let datasets = [];

  console.log(labels)
  labels.forEach((label, index) => {
    let dataset = {
      label: label,
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
      