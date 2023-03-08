import { dynamicColor, generateDatasets, normalizeLabels } from "./chart_helper";

$(()=> {
  Array.from(document.getElementsByClassName('single_option-chart')).forEach(singleOptionChart => {
    let chart = singleOptionChart.getContext('2d');
    let dataSingleOption = JSON.parse(chart.canvas.dataset.data);
    simpleBarsChart(chart, dataSingleOption);
  });

  Array.from(document.getElementsByClassName('multiple_option-chart')).forEach(singleOptionChart => {
    let chart = singleOptionChart.getContext('2d');
    let dataSingleOption = JSON.parse(chart.canvas.dataset.data);
    simpleBarsChart(chart, dataSingleOption);
  });

  Array.from(document.getElementsByClassName('matrix_multiple-chart')).forEach(matrixMultipleChart => {
    let chart = matrixMultipleChart.getContext('2d');
    let dataMultipleOption = JSON.parse(chart.canvas.dataset.data);
    simpleBarsChart(chart, dataMultipleOption);
  });

  Array.from(document.getElementsByClassName('matrix_single-chart')).forEach(matrixSingleChart => {
    let chart = matrixSingleChart.getContext('2d');
    let dataSingleMatrix = JSON.parse(chart.canvas.dataset.data);
    multipleBarsChart(chart, dataSingleMatrix);
  });
});

function simpleBarsChart(ctx, data) {
  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: normalizeLabels(JSON.parse(ctx.canvas.dataset.labels)),
      datasets: [{
        label: 'Number of Votes',
        data: data,
        backgroundColor: dynamicColor(),
        borderWidth: 1,
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: true,
          ticks: {
            stepSize: 1
          }
        }
      }
    }
  });
}

function multipleBarsChart(ctx, data) {
  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: normalizeLabels(JSON.parse(ctx.canvas.dataset.labels)),
      datasets: generateDatasets(data)
    },
    options: {
      scales: {
        y: {
          beginAtZero: true,
          ticks: {
            stepSize: 1
          }
        }
      }
    }
  });
}
