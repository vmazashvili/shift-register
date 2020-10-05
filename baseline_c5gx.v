module baseline_c5gx(
     
      ///////// CLOCK /////////
      input              CLOCK_125_p, ///LVDS
  

      ///////// KEY ///////// 1.2 V ///////
      input       [3:0]  KEY,

     

      ///////// LEDR ///////// 2.5 V ///////
      output      [9:0]  LEDR,

		output		[7:0] LEDG,

      ///////// SW ///////// 1.2 V ///////
      input       [9:0]  SW);

		
	wire[7:0] data_in;
	wire clk;
	wire rst;
	wire button;
	
	assign data_in=SW[7:0];
	
	assign clk=CLOCK_125_p;
	
	assign rst = KEY[0];
	assign button = KEY[1];
	
	reg[7:0] data_out;
	
	assign LEDG = mid1;
	assign LEDR[7:0]=data_out;
	reg tmp;
	assign LEDR[9]=tmp;
	
  
  
reg[7:0] mid1, mid2;
reg first_impulse;
always@(posedge clk)
	begin
		if(!button && first_impulse) begin
			mid1 <= data_in;
			mid2 <= mid1;
			data_out <= mid2;
			first_impulse <= 0;
		end
		else if(button) first_impulse <= 1;
		if(!rst) begin
			mid1 <= 0;
			mid2 <= 0;
			data_out <= 0;
		end
	end	


endmodule
