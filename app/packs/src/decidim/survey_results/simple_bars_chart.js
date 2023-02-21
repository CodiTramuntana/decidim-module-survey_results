import { dynamicColor, generateDatasets } from "./chart_helper";

$(()=> {
  let singleOptionChart = document.getElementById('single-option-chart').getContext('2d');
  let dataSingleOption = JSON.parse(singleOptionChart.canvas.dataset.data);
  simpleBarsChart(singleOptionChart, dataSingleOption);

  let multipleOptionChart = document.getElementById('multiple-option-chart').getContext('2d');
  let dataMultipleOption = JSON.parse(multipleOptionChart.canvas.dataset.data);
  simpleBarsChart(multipleOptionChart, dataMultipleOption);

  let singleMatrixChart = document.getElementById('single-matrix-chart').getContext('2d');
  let dataSingleMatrix = JSON.parse(singleMatrixChart.canvas.dataset.data);
  multipleBarsChart(singleMatrixChart, dataSingleMatrix);
});

function simpleBarsChart(ctx, data) {
  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: JSON.parse(ctx.canvas.dataset.labels),
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
      labels: JSON.parse(ctx.canvas.dataset.labels),
      datasets: generateDatasets(JSON.parse(ctx.canvas.dataset.labels), data)
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
