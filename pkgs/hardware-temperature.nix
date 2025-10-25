# Pending review
{
  writeShellApplication,
  lm_sensors,
  coreutils,
  gnugrep,
  gnused,
  gawk,
}:
writeShellApplication {
  name = "hwtemp";

  runtimeInputs = [
    lm_sensors
    coreutils
    gnugrep
    gnused
    gawk
  ];

  text = ''
    cpu_temp () {
      sensors | grep "Tdie:" | tr -d '+' | cut -d '.' -f1 | awk '{print $2}' | sed 's/$/°C/'
    }

    gpu_temp () {
      sensors | grep "Composite:" | tr -d '+' | cut -d '.' -f1 | awk '{print $2}' | sed 's/$/°C/'
    }

    print_help () {
      echo "Usage: hwtemp [OPTION]"
      echo "Show specific hardware temperature."
      echo
      echo "options:"
      echo "  -c, --cpu   show cpu temperature."
      echo "  -g, --gpu   show gpu temperature."
      echo "  -h, --help  show this help message."
    }

    invalid_argument () {
      echo "hwtemp: invalid option -- '$1'" >&2
      echo "Try 'hwtemp --help' for more information."
      exit 2
    }

    if [ $# -eq 0 ]; then
      echo "hwtemp: missing operand." >&2
      echo "Try 'hwtemp --help' for more information."
      exit 2
    fi

    case "$1" in
      -c|--cpu)
        cpu_temp
        ;;
      -g|--gpu)
        gpu_temp
        ;;
      -h|--help)
        print_help
        ;;
      *)
        invalid_argument "$1"
        ;;
    esac
  '';
}
