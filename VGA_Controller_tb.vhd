library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use std.textio.all;
  use ieee.std_logic_textio.all;

entity tb_vga_controller is -- keine Schnittstellen
end entity tb_vga_controller;

architecture testbench of tb_vga_controller is

  component vga_controller is
    port (
      clock_25    : in    std_logic;
      reset_n       : in    std_logic;
      h_sync      : out   std_logic;
      v_sync      : out   std_logic;
      valid_pixel : out   std_logic;
      data_in     : in    std_logic_vector(11 downto 0);
      data_out    : out   std_logic_vector(11 downto 0)
    );
  end component;

  -- Ports in Richtung nutzende Komponente
  signal clk_tb_s      : std_logic;
  signal reset_tb_s    : std_logic;
  signal h_sync_s      : std_logic;
  signal v_sync_s      : std_logic;
  signal valid_pixel_s : std_logic;
  signal data_in_s     : std_logic_vector(11 downto 0);
  signal data_out_s    : std_logic_vector(11 downto 0);

begin

  dut : component vga_controller
    port map (
      clock_25    => clk_tb_s,
      reset_n       => reset_tb_s,
      h_sync      => h_sync_s,
      v_sync      => v_sync_s,
      valid_pixel => valid_pixel_s,
      data_in     => data_in_s,
      data_out    => data_out_s
    );

  p_clk : process is

  begin

    clk_tb_s <= '1';
    wait for 20 ns;
    clk_tb_s <= '0';
    wait for 20 ns;

  end process p_clk;

  tests_p : process is
  begin

    reset_tb_s <= '0' after 0 ns, '1' after 10 ns;
    data_in_s  <= "111100000000" after 0 ns;

    wait;

  end process tests_p;

end architecture testbench;
