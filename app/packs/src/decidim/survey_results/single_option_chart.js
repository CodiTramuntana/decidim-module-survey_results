import { dynamicColor } from "./chart_helper";

$(()=> {
  let ctx = document.getElementById('single-option-chart').getContext('2d');
  let data = JSON.parse(ctx.canvas.dataset.data);
  let singleOptionChart = new Chart(ctx, {
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
      responsive: true,
      plugins: {
        legend: {
          position: 'top',
        },
      },
      scales: {
        y: {
          min: 0,
          ticks: {
            stepSize: 1
          }
        }
      }
    }
  });
})
