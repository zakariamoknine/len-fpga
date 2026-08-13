# len-fpga

len-fpga is an FPGA-based SoC platform, designed primarly to run the *len* kernel

> [!WARNING]
>
> This project currently as-in targets the Nexys A7-100T FPGA exclusively. Many configurations are hardcoded to this board.

# SoC Design

<p float="left">
  <img src="/docs/images/soc.png" alt="SoC Design" width="100%">
</p>

# Peripherals

### AXI DDR2 MIG

Xilinx Vivado IP that provides an AXI interface to the 128 MiB DDR2 memory. It translates AXI transactions into the low-level signals required by the DDR2 memory interface.

### UART 16550

Standard 16550-compatible UART peripheral providing serial communication through TX and RX. The baud rate is configurable, allowing it to be used with different serial communication speeds.

### VGA

VGA controller with DMA access to the 128 MiB DDR2 memory. A framebuffer base address can be configured, pointing to a 640×480 framebuffer using 4 bits per pixel, which the controller continuously reads for display output.

### CLINT

Core-Local Interruptor providing timer and software interrupts to the processor. It is used for processor-local interrupt mechanisms such as timers and inter-processor or software-

### PLIC

Platform-Level Interrupt Controller that collects interrupts from different sources and forwards them to the processor individually, allowing the processor to identify and handle peripheral interrupts.

### PMC

Power Management Controller used to control the SoC's power state. Writing specific control values allows software to power off or reboot the entire SoC.

# Power & Resource Utilization

<p float="left">
  <img src="/docs/images/power.png" alt="Power" width="48%">
  <img src="/docs/images/resource.png" alt="Resources" width="48%">
</p>
