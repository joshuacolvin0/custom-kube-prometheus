{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'awesome-kubelet',
        rules: [
          {
            alert: 'VolumeOutOfDiskSpace',
            expr: |||
                kubelet_volume_stats_available_bytes / kubelet_volume_stats_capacity_bytes * 100 < 10
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: "Volume out of disk space (instance {{ $labels.instance }})",
              description: "Volume is almost full (< 10% left)\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
          {
            alert: 'VolumeFullInFourDays',
            expr: |||
                100 * (kubelet_volume_stats_available_bytes / kubelet_volume_stats_capacity_bytes) < 15 and predict_linear(kubelet_volume_stats_available_bytes[6h], 4 * 24 * 3600) < 0
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'error',
            },
            annotations: {
              summary: "Volume full in four days (instance {{ $labels.instance }})",
              description: "{{ $labels.namespace }}/{{ $labels.persistentvolumeclaim }} is expected to fill up within four days. Currently {{ $value | humanize }}% is available.\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
          {
            alert: 'StatefulsetDown',
            expr: |||
                  (kube_statefulset_status_replicas_ready / kube_statefulset_status_replicas_current) != 1
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'error',
            },
            annotations: {
              summary: "StatefulSet down (instance {{ $labels.instance }})",
              description: "A StatefulSet went down\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
        ],
      },
    ],
  },
}
