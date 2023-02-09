import { dynamicColor } from "./chart_helper";

$(()=> {
  let singleOptionChart = document.getElementById('single-option-chart').getContext('2d');
  let dataSingleOption = JSON.parse(singleOptionChart.canvas.dataset.data);
  simpleBarsChart(singleOptionChart, dataSingleOption);

  let multipleOptionChart = document.getElementById('multiple-option-chart').getContext('2d');
  let dataMultipleOption = JSON.parse(multipleOptionChart.canvas.dataset.data);
  simpleBarsChart(multipleOptionChart, dataMultipleOption);
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
