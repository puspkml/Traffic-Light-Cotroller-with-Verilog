module tb_trafficLight();
	reg clk,rst,vech1,vech2;
	wire [2:0] light1,light2;
	initial begin
		clk = 1'b1;
	end
	always #5 clk =~clk;
	trafficLight dut (.clk(clk),.rst(rst),.vech1(vech1),.vech2(vech2),.light1(light1),.light2(light2));
	initial begin
		$dumpfile("trafficLight.vcd");
		$dumpvars(0,tb_trafficLight);
		rst = 1; vech1=0;vech2=0;#10;
		rst=0;#10;
		vech1=0;vech2=1;#50;
		vech1=1;vech2=0;#50;
		vech1=1;vech2=1;#100;
		vech1=0;vech2=0;#30;
		rst=1;#10
		$finish;
	end
endmodule
