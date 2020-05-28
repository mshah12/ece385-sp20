module control_unit (input logic  clk, run, reset, clearALoadB, m, 
							output logic clearA, clearB, shift, addOrSub, loadA, loadB, adderEn, input m1); //add = 0, sub = 1

	 enum logic [4:0] {ResetState, ClearedA, A1, A2, A3, A4, A5, A6, A7, A8, S1,S2,S3,S4,S5,S6,S7,S8, Halt, Halt2} curr_state = ResetState, next_state=ResetState;

    always_ff @ (posedge clk )  
    begin
        if (reset)    
            curr_state <= ResetState;   	
        else 
				if (clearALoadB)
					curr_state <= ClearedA;
				else
					curr_state <= next_state;
    end

	always_comb
    begin
					clearA=1'b0; /*default signal output*/
					 clearB=1'b0;
					 shift=1'b0; 
					 addOrSub=1'b0;
					 loadA=1'b0;
					 loadB=1'b0;
					 adderEn = 1'b0;
					 
		  next_state  = curr_state;
   	  
		  unique case (curr_state) 
				ResetState:   next_state = ClearedA;
            ClearedA :  if (run && m==0)next_state = S1;else if(run && m == 1)next_state = A1;					
				S1 :if(m1==0) next_state = S2;else if(m1==1)next_state = A2;
            S2 :if(m1==0)next_state = S3;else if(m1==1)next_state = A3;
            S3 :if(m1==0)next_state = S4;else if(m1==1)next_state = A4;
            S4 :if(m1==0)next_state = S5;else if(m1==1) next_state = A5;
            S5 :if(m1==0)next_state = S6;else if(m1==1)next_state = A6;
            S6 :if(m1==0)next_state = S7;else if(m1==1)next_state = A7;
            S7 :if(m1==0)next_state = S8;else if(m1==1) next_state = A8;
            S8 :next_state = Halt;
				A1 :next_state = S1; /*Shift state*/
				A2 :next_state = S2; /*Shift state*/
				A3 :next_state = S3; /*Shift state*/
				A4 :next_state = S4; /*Shift state*/
				A5 :next_state = S5; /*Shift state*/
				A6 :next_state = S6; /*Shift state*/
				A7 :next_state = S7; /*Shift state*/
				A8 :next_state = S8; /*Shift state*/
            Halt :    if (~run) 
                       next_state = Halt2;
				Halt2: if(run)
							next_state = ClearedA;
        endcase
		  
        case (curr_state) 
	   	   ResetState: 	
	         begin
					 clearA=1'b1; 
					 clearB=1'b1;
					 shift=1'b0; 
					 addOrSub=1'b0;
					 loadA=1'b0;
					 loadB=1'b0;
		      end
	   	   ClearedA: 	
	         begin
					 clearA=1'b1; 
					 clearB=1'b0;
					 shift=1'b0; 
					 addOrSub=1'b0;
					 loadA=1'b0;
					 loadB=1'b1;
		      end
				S1,S2,S3,S4,S5,S6,S7,S8:
				begin 
					clearA=1'b0; /*shift*/
					 clearB=1'b0;
					 shift=1'b1; 
					 addOrSub=1'b0;
					 loadA=1'b0;
					 loadB=1'b0;
					 adderEn = 1'b0;
				end
				
				A1,A2,A3,A4,A5,A6,A7:
				begin 
					clearA=1'b0; 
					 clearB=1'b0; /*Add*/
					 shift=1'b0; 
					 addOrSub=1'b0;
					 loadA=1'b0;
					 loadB=1'b0;
					 adderEn = 1'b1;
				end
				A8:
				begin
					clearA=1'b0; 
					 clearB=1'b0; /*subtract*/
					 shift=1'b0; 
					 addOrSub=1'b1;
					 loadA=1'b0;
					 loadB=1'b0;
					 adderEn = 1'b1;
				end		
	   	   Halt: 
		      begin
					 clearA=1'b0; 
					 clearB=1'b0;
					 shift=1'b0; 
					 addOrSub=1'b0;
					 loadA=1'b0;
					 loadB=1'b0;
					 adderEn = 1'b0;
		      end
				Halt2: 
		      begin
					 clearA=1'b0; 
					 clearB=1'b0;
					 shift=1'b0; 
					 addOrSub=1'b0;
					 loadA=1'b0;
					 loadB=1'b0;
					 adderEn = 1'b0;
		      end
	   	  
        endcase
	
    end

endmodule
