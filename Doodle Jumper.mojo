<?xml version="1.0" encoding="UTF-8"?>
<project name="Doodle Jumper" board="Mojo V3" language="Lucid">
  <files>
    <src>adder16.luc</src>
    <src top="true">mojo_top.luc</src>
    <src>alu16.luc</src>
    <src>shift16.luc</src>
    <src>lshift16.luc</src>
    <src>max7219_4chain.luc</src>
    <src>mult16.luc</src>
    <src>memory.luc</src>
    <src>instruction_rom.luc</src>
    <src>display.luc</src>
    <src>led_matrix_32x8.luc</src>
    <src>arith16.luc</src>
    <src>rshift16.luc</src>
    <src>two_digit_7seg.luc</src>
    <src>game_controller.luc</src>
    <src>instruction_counter.luc</src>
    <src>compare16.luc</src>
    <src>boole16.luc</src>
    <ucf lib="true">mojo.ucf</ucf>
    <ucf>ui.ucf</ucf>
    <component>pipeline.luc</component>
    <component>spi_master.luc</component>
    <component>counter.luc</component>
    <component>button_conditioner.luc</component>
    <component>reset_conditioner.luc</component>
    <component>bin_to_dec.luc</component>
    <component>edge_detector.luc</component>
  </files>
</project>
