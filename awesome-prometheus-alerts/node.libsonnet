{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'awesome-node-exporter',
        rules: [
          {
            alert: 'NodeOutOfMemory',
            expr: |||
                (node_memory_MemFree_bytes + node_memory_Cached_bytes + node_memory_Buffers_bytes) / node_memory_MemTotal_bytes * 100 < 10
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: "Out of memory (instance {{ $labels.instance }})",
              description: "Node memory is filling up (< 10% left)\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
          {
            alert: 'NodeUnusualNetworkThroughputIn',
            expr: |||
                sum by (instance) (irate(node_network_receive_bytes_total[2m])) / 1024 / 1024 > 100
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: "Unusual network throughput in (instance {{ $labels.instance }})",
              description: "Host network interfaces are probably receiving too much data (> 100 MB/s)\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
          {
            alert: 'NodeUnusualNetworkThroughputOut',
            expr: |||
                sum by (instance) (irate(node_network_transmit_bytes_total[2m])) / 1024 / 1024 > 100
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: "Unusual network throughput out (instance {{ $labels.instance }})",
              description: "Host network interfaces are probably sending too much data (> 100 MB/s)\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
          {
            alert: 'NodeUnusualDiskReadRate',
            expr: |||
                sum by (instance) (irate(node_disk_read_bytes_total[2m])) / 1024 / 1024 > 50
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: "Unusual disk read rate (instance {{ $labels.instance }})",
              description: "Disk is probably reading too much data (> 50 MB/s)\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
          {
            alert: 'NodeUnusualDiskWriteRate',
            expr: |||
                sum by (instance) (irate(node_disk_written_bytes_total[2m])) / 1024 / 1024 > 50
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: "Unusual disk write rate (instance {{ $labels.instance }})",
              description: "Disk is probably writing too much data (> 50 MB/s)\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
          {
            alert: 'NodeOutOfDiskSpace',
            expr: |||
                node_filesystem_free_bytes{mountpoint ="/rootfs"} / node_filesystem_size_bytes{mountpoint ="/rootfs"} * 100 < 10
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: "Out of disk space (instance {{ $labels.instance }})",
              description: "Disk is almost full (< 10% left)\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
          {
            alert: 'NodeOutOfInodes',
            expr: |||
                node_filesystem_files_free{mountpoint ="/rootfs"} / node_filesystem_files{mountpoint ="/rootfs"} * 100 < 10
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: "Out of inodes (instance {{ $labels.instance }})",
              description: "Disk is almost running out of available inodes (< 10% left)\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
          {
            alert: 'NodeUnusualDiskReadLatency',
            expr: |||
                rate(node_disk_read_time_seconds_total[1m]) / rate(node_disk_reads_completed_total[1m]) > 100
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: "Unusual disk read latency (instance {{ $labels.instance }})",
              description: "Disk latency is growing (read operations > 100ms)\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
          {
            alert: 'NodeUnusualDiskWriteLatency',
            expr: |||
                rate(node_disk_write_time_seconds_total[1m]) / rate(node_disk_writes_completed_total[1m]) > 100
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: "Unusual disk write latency (instance {{ $labels.instance }})",
              description: "Disk latency is growing (write operations > 100ms)\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
          {
            alert: 'NodeHighCpuLoad',
            expr: |||
                100 - (avg by(instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100) > 80
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: "High CPU load (instance {{ $labels.instance }})",
              description: "CPU load is > 80%\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
          {
            alert: 'NodeContextSwitching',
            expr: |||
                rate(node_context_switches_total[5m]) > 1000
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: "Context switching (instance {{ $labels.instance }})",
              description: "Context switching is growing on node (> 1000 / s)\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
          {
            alert: 'NodeSwapIsFillingUp',
            expr: |||
                (1 - (node_memory_SwapFree_bytes / node_memory_SwapTotal_bytes)) * 100 > 80
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: "Swap is filling up (instance {{ $labels.instance }})",
              description: "Swap is filling up (>80%)\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
          {
            alert: 'NodeSystemdServiceFailed',
            expr: |||
                node_systemd_unit_state{state="failed"} == 1
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'warning',
            },
            annotations: {
              summary: "SystemD service failed (instance {{ $labels.instance }})",
              description: "Service {{ $labels.name }} failed\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}",
            },
          },
        ],
      },
    ],
  },
}
