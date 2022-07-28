module ADD_32 //(x,y,cin,sum);
  ( input clk,
    input [31:0] x,
    input [31:0] y,
    input [31:0] c_in, 
    output reg [31:0] c_out,
    output reg [31:0] sum);
  //always @ (x or y or c_in) begin
    //assign {c_out, sum} = x + y + c_in;
  
  always @(posedge clk) begin
       {c_out, sum} = x + y + c_in;
    //sum <= x + y;
  end
  
endmodule



module MUL_32( input clk,
               input [31:0] x, y,
              output reg [31:0] cout, z );
  //assign {cout, z} = x * y;
  always @(posedge clk) begin
        
        {cout, z} = x * y;
  
  end
endmodule


module FMA_32(input clk, 
              input [31:0] x,y,z,
              output [31:0] out );
  wire [31:0] p_co,prod;
  wire [31:0] s_co, s_cin;
  assign s_cin = 0;
  
  MUL_32 m(clk,x,y,p_co,prod);
  ADD_32  s(clk,prod,z,s_cin,s_co,out);
  
endmodule


//say you want to evaluate ---should be working
module Horn_32(input  clk,
               input [31:0] c0,c1,c2,c3,c4,c5,c6,
               input [31:0] x,
               //input [31:0] z0,
               output wire [31:0] out);
 // 2X^6 + 3X^5 + 2X^4 +7X^3 + 8X^2 + 2X + 4 = out
  //reg [31:0] coeff;
  wire [31:0] z0,z1,z2,z3,z4;
  
  //z0 = (2*x) + 3 (c5)
  //z1 = (z0*x) + 2 (c4)
  //z2 = (z1*x) + 7 (c3)
  //z3 = (z2*x) + 8 (c2)
  //z4 = (z3*x) + 2 (c1)
  //out = (z4*x) + 4 (c0)
  
  FMA_32 ud(clk,c6,x,c5,z0);
  FMA_32 u1(clk,z0,x,c4,z1);
  FMA_32 u2(clk,z1,x,c3,z2);
  FMA_32 u3(clk,z2,x,c2,z3);
  FMA_32 u4(clk,z3,x,c1,z4);
  FMA_32 u5(clk,z4,x,c0,out);
  
  
  
  
endmodule 
