module trafficLight(
	input wire clk,
	input wire rst,
	input wire vech1,
	input wire vech2,
	output reg [2:0] light1,
	output reg [2:0] light2);

	localparam g1r2 = 2'b00;
	localparam y1r2 = 2'b01;
	localparam r1g2 = 2'b10;
	localparam r1y2 = 2'b11;
	
	reg [3:0] count;
	localparam timer =4'b0101; 
	localparam delay =4'b0001;
	
	reg [1:0] current, next;

	localparam green = 3'b100;
	localparam yellow = 3'b010;
	localparam red = 3'b001;

	always @(posedge clk) begin
		if (rst==1) begin
			current<=g1r2;			
			count<=4'b0000;
		end else begin
			current<=next;
			if (current!=next) begin
				count<=4'b0000;
			end else begin
				count<= count+1;
			end
		end	
	end
	always @(*) begin
		next = current;
		case (current)
			g1r2:begin
				if (vech1==0 && vech2==1) begin
					next=y1r2;
				end else if (vech1==1 && vech2==0) begin
					next=g1r2;
				end else if (vech1==1 && vech2==1) begin
					if (count>=timer) begin
						next=y1r2;
					end else begin
						next=g1r2;
					end	
				end else begin
					next=g1r2;
				end
			end
			y1r2:begin
				if (count>=delay) begin
					next=r1g2;
				end else begin
					next=y1r2;
				end
			end
                        r1g2:begin
                                if (vech1==0 && vech2==1) begin
                                        next=r1g2;
                                end else if (vech1==1 && vech2==0) begin
                                        next=r1y2;
                                end else if (vech1==1 && vech2==1) begin
                                        if (count>=timer) begin
                                                next=r1y2;
                                        end else begin
                                                next=r1g2;
                                        end
                                end else begin
                                        next=r1g2;
                                end
                        end
		
			r1y2:begin
                                if (count>=delay) begin
                                        next=g1r2;
                                end else begin
                                        next=r1y2;
                                end
                        end
			default:begin
				light1=green;
				light2=green;
			end
		endcase
	end
	always @(*) begin
		light1 = green;
		light2 = green;
		if (rst == 1) begin
                        light1 = green;
                        light2 = green;
                end else begin
			case (current)
				g1r2:begin
					light1=green;
					light2=red;
				end
				y1r2:begin
					light1=yellow;
					light2=red;
				end
				r1g2:begin
					light1=red;
					light2=green;
				end
				r1y2:begin
					light1=red;
					light2=green;
				end
			endcase
		end	
	end
endmodule
