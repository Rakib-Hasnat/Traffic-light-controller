Module Code:





module traffic_light_controller(
  input clk,
  input reset,
  output reg [2:0] lights );

  reg [2:0] state;
  reg [3:0] counter;
  parameter RED = 3'b100, GREEN = 3'b010 , YELLOW = 3'b001;
  
  always @(posedge clk or posedge reset )
    
    begin 
      if(reset) 
        begin
          state<= RED;
          counter <= 0;
        end
      else
        begin
          counter <= counter + 1;
          
          case(state)
            
            RED: 
              begin
                if (counter == 4)
                begin
                  state <= GREEN;
                  counter <= 0;
                end
              end
            
            GREEN:
              begin
                if(counter == 4)
                  begin
                    state <= YELLOW;
                    counter <= 0;
                  end
              end
            
            YELLOW: 
              begin
                if(counter == 1)
                  begin
                    state <= RED;
                    counter <= 0;
                  end
              end
               
          endcase
          
        end                  
    end
    
  always @(*)
    begin
    lights = state;
    end
  
endmodule









Test bench:

module tb_traffic_light;
  
  reg clk;
  reg reset;
  wire [2:0] lights;
  
  traffic_light_controller uut(
    .clk(clk),
    .reset(reset),
    .lights(lights)
  );
  
  initial begin 
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin
    $dumpfile("traffic_light.vcd");
    $dumpvars(0, tb_traffic_light);
    
    reset =1;
    #10 reset = 0;
    
    #200 $finish;
  end
  
endmodule




    