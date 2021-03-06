{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'awesome-coredns',
        rules: [
          {
            alert: 'CorednsPanicCount',
            expr: |||
                increase(coredns_panic_count_total[10m]) > 0
            ||| % $._config,
            'for': '3m',
            labels: {
              severity: 'error',
            },
            annotations: {
              summary: "CoreDNS Panic Count (instance {{ $labels.instance }})",
              description: "Number of CoreDNS panics encountered\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
        ],
      },
    ],
  },
}
