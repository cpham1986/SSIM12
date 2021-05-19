%This is a script for the TCU stuff for 349
%it will use function to define things like AZ, BAZ and so on. 
%then there will be two functions called sequence 1 and sequence 2 and
%those will be the sequences mentioned in the ANNEX 10 and will make calls
%to the AZ and BZ functions when needs and will output an array. The main
%script will combine the sequence arrays into the array that will be
%exported to the SSIM 

clear;
ClkCycle = 64;
AZ = 0;
EL = 0;
BAZ = 0;
BD1 = 0;
BD2 = 0;
BD3 = 0;
BD4 = 0;
BD5 = 0;
BD6 = 0;
AD1 = 0;
TxEn = 1;
BPSK = 2;
ToFro = 3;
SBstart = 4; %scanning beam start 
AntSel1 = 5;
AntSel2 = 6;
AntSel3 = 7;
AntSelRd = 8;

%main code here

totalMatrix = main();




%sequences
function SSIM = main(~)
%Starting on SEQ1 and alternating between there are 4 SEQ1 and 4 SEQ2
MainCall1 = FunctionSEQ1();
pause1 = zeros(1000,8);
MainCall2 = FunctionSEQ2();
pause2 = zeros(13000,8);

MainCall3 = FunctionSEQ1();
pause3 = zeros(19000,8);
MainCall4 = FunctionSEQ2();
pause4 = zeros(2000,8);


MainCall5 = FunctionSEQ1();
pause5 = zeros(20000,8);
MainCall6 = FunctionSEQ2();
pause6 = zeros(6000,8);

MainCall7 = FunctionSEQ1();
%no pause
MainCall8 = FunctionSEQ2();
pause7 = zeros(18000,8);

SSIM = cat(1,MainCall1,pause1,MainCall2,pause2, MainCall3,pause3,MainCall4,pause4,MainCall5, pause5 ,MainCall6,pause6, MainCall7,pause7,MainCall8);

end 


%SEQ 1 calls EL, BDW, AZ, BDW, EL, BDW, BAZ, BDW2, EL, BDW. (10 calls ) 
function SEQ1 = FunctionSEQ1(~)
SEQCALL1 = FunctionEL();
SEQCALL2 = FunctionBD1();
SEQ1Pause1 = zeros(2200,8);
SEQCALL3 = FunctionAZ();
SEQCALL4 = FunctionBD3();
%add another pause1 
SEQCALL5 = FunctionEL();
SEQCALL6 = FunctionBD4();
SEQCALL7 = FunctionBAZ();
SEQCALL8 = FunctionBD2();
SEQCALL9 = FunctionEL();
SEQCALL10 = FunctionBD5();
SEQ1Pause3 = zeros(2500,8);
SEQ1 = cat(1,SEQCALL1,SEQCALL2,SEQ1Pause1,SEQCALL3,SEQCALL4, SEQ1Pause1,SEQCALL5,SEQCALL6,SEQCALL7,SEQCALL8,SEQCALL9,SEQCALL10,SEQ1Pause3);

end 


%SEQ2 calls EL, BDW, AZ, BDW, EL, ADW1 (Aux data word), EL, BDW. (8 calls) 

function SEQ2 = FunctionSEQ2(~)
SEQ2CALL1 = FunctionEL();
SEQ2CALL2 = FunctionBD6();
SEQ2Pause1 = zeros(2200,8);
SEQ2CALL3 = FunctionAZ();
SEQ2CALL4 = FunctionBD1();
%add SEQ2Pause1 here 
SEQ2CALL5 = FunctionEL();
SEQ2CALL6 = FunctionADA();
SEQ2Pause2 = zeros(12300,8);
SEQ2CALL7 = FunctionEL();
SEQ2CALL8 = FunctionBD2();
SEQ2Pause3 = zeros(2400,8);
SEQ2 = cat(1,SEQ2CALL1,SEQ2CALL2,SEQ2Pause1,SEQ2CALL3,SEQ2CALL4,SEQ2Pause1,SEQ2CALL5,SEQ2CALL6,SEQ2Pause2,SEQ2CALL7,SEQ2CALL8,SEQ2Pause3);

end





%these are the funcitons 
  %AZ stuff 
  function AZDataArray = FunctionAZ(~)
        TxEn = 1;
        BPSK = 2;
        ToFro = 3;
        SBstart = 4; %scanning beam start 
        AntSel1 = 5;
        AntSel2 = 6;
        AntSel3 = 7;
        AntSelRd = 8;
      AZDataArray(15900,8) = 0;
      for i = 1:831
      AZDataArray(i,BPSK) = 0;%carrier acquisition
      end 
      
      for i = 1:15688
      AZDataArray(i,TxEn) = 1;%sets enable high for the entire 2d array. will be set low when it needs to be 
      end 
      
      for i = 1:64
           AZDataArray(i,AntSelRd) = 1;
      end
      
      %these are for the time sync first 5 bits maybe
      AZDataArray(832:896,BPSK) = 1;
      AZDataArray(896:960,BPSK) = 1;
      AZDataArray(960:1024,BPSK) = 1;
      AZDataArray(1024:1088,BPSK) = 0;
      AZDataArray(1088:1152,BPSK) = 1;
      %function ID for AZ 
      AZDataArray(1152:1216,BPSK) = 0;
      AZDataArray(1216:1280,BPSK) = 0;
      AZDataArray(1280:1344,BPSK) = 1;
      AZDataArray(1344:1408,BPSK) = 1;
      AZDataArray(1408:1472,BPSK) = 0;
      AZDataArray(1472:1536,BPSK) = 0;
      AZDataArray(1536:1600,BPSK) = 1;
        %this is the end of the preamble 
        %skips Morse Code 
        
    %this is the antenna select and what column that are binded to 
    %         AntSel1 = 5;
    %         AntSel2 = 6;
    %         AntSel3 = 7;

        %rear OCI 010 this gets transmitted every clock cycle for 2 cycles
        AZDataArray(2048:2176,AntSel1) = 0;
        AZDataArray(2048:2176,AntSel2) = 1;
        AZDataArray(2048:2176,AntSel3) = 0;      
        %Antenna select read
        AZDataArray(2048:2112,AntSelRd) = 1;

        
        %left OCI 001 this gets transmitted every clock cycle for 2 cycles
        AZDataArray(2176:2304,AntSel1) = 0;
        AZDataArray(2176:2304,AntSel2) = 0;
        AZDataArray(2176:2304,AntSel3) = 1;
        %Antenna select read
        AZDataArray(2176:2240,AntSelRd) = 1;
        
        %right OCI 011 this gets transmitted every clock cycle for 2 cycles
        AZDataArray(2304:2432,AntSel1) = 0;
        AZDataArray(2304:2432,AntSel2) = 1;
        AZDataArray(2304:2432,AntSel3) = 1;
        %Antenna select read
        AZDataArray(2304:2368,AntSelRd) = 1;

        
        %set EVERYTHING to 0 cause the test is ignored  
        %Tell SSIM that we are doing this 
        AZDataArray(2433:2559,TxEn) = 0;%sets the enable to 0 for the duration of the pause 
        %might not need this cause enable is low .... ask SSIM how they did it
        %AZDataArray(2432,AntSel1) = 0;
        %AZDataArray(2432,AntSel2) = 0;
        %AZDataArray(2432,AntSel3) = 0;
        %Antenna select read
        %AZDataArray((2432 + ClkCycle),AntSelRd) = 1;
        %this is only 1 for one clock cycle
        %AZDataArray((2432 + (2*ClkCycle)),AntSelRd) = 0;
        
        
        
        %to scan 
        %since there is no interupt to the antsel for the duration
        %that the SB is up (since the pause doesn't affect these) this handles the to and fro 
        %by going from the starts of To Scan 2.560ms to the end of FRO scan
        %15.560ms
        AZDataArray(2560:15560,AntSel1) = 1;
        AZDataArray(2560:15560,AntSel2) = 0;
        AZDataArray(2560:15560,AntSel3) = 1;
        %SBstart along with the to/fro
        AZDataArray(2560:8759,ToFro) = 1;
        AZDataArray(2560:8759,SBstart) = 1;
        %Antenna select read
        AZDataArray(2560:2624,AntSelRd) = 1;


        %add pause starts at 8760  (skip midpoint) midpoint starts at 9060
        %and ends at 9360 when the Fro scan starts
        %antenna stays the same because Enable, TO/FRO, and SBStart is 0
        AZDataArray(8761:9359,TxEn) = 0;%sets the enable to 0 for the duration of the pause 
        %might not need cause it is intially an array of 0s but just in
        %case
        %AZDataArray(8760:9360,ToFro) = 0;%sets the TO/Fro to 0 for the duration of the pause 
        %AZDataArray(8760:9360,SBStart) = 0;%sets the Scanning beam start to 0 for the duration of the pause 
        
        %fro scan 
        AZDataArray(9360:15560,ToFro) = 0;
        AZDataArray(9360:15560,SBstart) = 1;
        
        %skipping FRO test
        %since the 101 fro the SB ends here in the antsel that means that
        %antselRead must go high for once clock cycles 
        AZDataArray(15560:15624,AntSelRd) = 1;
        
        %at 15.688ms the end funciton starts and that means everything goes
        %to 0 ask if enable also goes 0 
        %AZDataArray(15688:15900,TxEn) = 0;
        
  end 
        
     %BAZ stuff 
   function BAZDataArray = FunctionBAZ(~)
        TxEn = 1;
        BPSK = 2;
        ToFro = 3;
        SBstart = 4; %scanning beam start 
        AntSel1 = 5;
        AntSel2 = 6;
        AntSel3 = 7;
        AntSelRd = 8; 

     BAZDataArray(11900,8) = 0;
      for i = 1:831
      BAZDataArray(i,BPSK) = 0;%carrier acquisition
      end 
      
      for i = 1:11688
      BAZDataArray(i,TxEn) = 1;%sets enable high for the entire 2d array. will be set low when it needs to be 
      end 
      
            for i = 1:64
           BAZDataArray(i,AntSelRd) = 1;
      end
      
      
      %these are for the time sync first 5 bits maybe
      BAZDataArray(832:896,BPSK) = 1;
      BAZDataArray(896:960,BPSK) = 1;
      BAZDataArray(960:1024,BPSK) = 1;
      BAZDataArray(1024:1088,BPSK) = 0;
      BAZDataArray(1088:1152,BPSK) = 1;
      %function ID for BAZ 
      BAZDataArray(1152:1216,BPSK) = 1;
      BAZDataArray(1216:1280,BPSK) = 0;
      BAZDataArray(1280:1344,BPSK) = 0;
      BAZDataArray(1344:1408,BPSK) = 1;
      BAZDataArray(1408:1472,BPSK) = 0;
      BAZDataArray(1472:1536,BPSK) = 0;
      BAZDataArray(1536:1600,BPSK) = 1;
      
         %this is the end of the preamble 
        %skips Morse Code 
        %BAZ follows the same procedure as the AZ for the OCI and only
        %starts to differ when it gets to the To Fro stuff
        
    %this is the antenna select and what column that are binded to 
    %         AntSel1 = 5;
    %         AntSel2 = 6;
    %         AntSel3 = 7;

        %rear OCI 010 this gets transmitted every clock cycle for 2 cycles
        BAZDataArray(2048:2176,AntSel1) = 0;
        BAZDataArray(2048:2176,AntSel2) = 1;
        BAZDataArray(2048:2176,AntSel3) = 0;      
        %Antenna select read
        BAZDataArray(2048:2112,AntSelRd) = 1;

        
        %left OCI 001 this gets transmitted every clock cycle for 2 cycles
        BAZDataArray(2176:2304,AntSel1) = 0;
        BAZDataArray(2176:2304,AntSel2) = 0;
        BAZDataArray(2176:2304,AntSel3) = 1;
        %Antenna select read
        BAZDataArray(2176:2240,AntSelRd) = 1;
        
        %right OCI 011 this gets transmitted every clock cycle for 2 cycles
        BAZDataArray(2304:2432,AntSel1) = 0;
        BAZDataArray(2304:2432,AntSel2) = 1;
        BAZDataArray(2304:2432,AntSel3) = 1;
        %Antenna select read
        BAZDataArray(2304:2368,AntSelRd) = 1;

        
        %set EVERYTHING to 0 cause the test is ignored  
        %Tell SSIM that we are doing this 
        BAZDataArray(2433:2559,TxEn) = 0;%sets the enable to 0 for the duration of the pause 
        %might not need this cause enable is low .... ask SSIM how they did it
        %AZDataArray(2432,AntSel1) = 0;
        %AZDataArray(2432,AntSel2) = 0;
        %AZDataArray(2432,AntSel3) = 0;
        %Antenna select read
        %AZDataArray((2432 + ClkCycle),AntSelRd) = 1;
        %this is only 1 for one clock cycle
        %AZDataArray((2432 + (2*ClkCycle)),AntSelRd) = 0;
        
        
        
        %to scan 
        %since there is no interupt to the antsel for the duration
        %that the SB is up (since the pause doesn't affect these) this handles the to and fro 
        %by going from the starts of To Scan 2.560ms to the end of FRO scan
        %11.560ms
        BAZDataArray(2560:11560,AntSel1) = 1;
        BAZDataArray(2560:11560,AntSel2) = 0;
        BAZDataArray(2560:11560,AntSel3) = 1;
        %SBstart along with the to/fro
        BAZDataArray(2560:6760,ToFro) = 1;
        BAZDataArray(2560:6760,SBstart) = 1;
        %Antenna select read
        BAZDataArray(2560:2624,AntSelRd) = 1;
        
        %add pause starts at 8760  (skip midpoint) midpoint starts at 9060
        %and ends at 9360 when the Fro scan starts
        %antenna stays the same because Enable, TO/FRO, and SBStart is 0
        BAZDataArray(6761:7359,TxEn) = 0;%sets the enable to 0 for the duration of the pause 
        
        
        %fro scan 
        BAZDataArray(7360:11560,ToFro) = 0;
        BAZDataArray(7360:11560,SBstart) = 1;
        
        %skipping FRO test
        %since the 101 fro the SB ends here in the antsel that means that
        %antselRead must go high for once clock cycles 
        BAZDataArray(11560:11624,AntSelRd) = 1;
        
   end 
   
   
      %Elevation stuff 
   function ELDataArray = FunctionEL(~)
        TxEn = 1;
        BPSK = 2;
        ToFro = 3;
        SBstart = 4; %scanning beam start 
        AntSel1 = 5;
        AntSel2 = 6;
        AntSel3 = 7;
        AntSelRd = 8;


      ELDataArray(5600,8) = 0;
      for i = 1:831
      ELDataArray(i,BPSK) = 0;%carrier acquisition
      end 
      
      for i = 1:5356
      ELDataArray(i,TxEn) = 1;%sets enable high for the entire 2d array. will be set low when it needs to be 
      end 
      
            for i = 1:64
           ELDataArray(i,AntSelRd) = 1;
      end
      
      
      %these are for the time sync first 5 bits maybe
      ELDataArray(832:896,BPSK) = 1;
      ELDataArray(896:960,BPSK) = 1;
      ELDataArray(960:1024,BPSK) = 1;
      ELDataArray(1024:1088,BPSK) = 0;
      ELDataArray(1088:1152,BPSK) = 1;
      %function ID for EL
      ELDataArray(1152:1216,BPSK) = 1;
      ELDataArray(1216:1280,BPSK) = 1;
      ELDataArray(1280:1344,BPSK) = 0;
      ELDataArray(1344:1408,BPSK) = 0;
      ELDataArray(1408:1472,BPSK) = 0;
      ELDataArray(1472:1536,BPSK) = 0;
      ELDataArray(1536:1600,BPSK) = 1;
      %this is the end of the preamble 
       
      %there is a processor pause.
      %set enable = 0 for the duration between 1.600ms and 1.728 ms 
      ELDataArray(1601:1727,TxEn) = 0;
      
     
      %EL uses the UOCI which is that same as the rear OCI 
      %rear OCI 010 this gets transmitted every clock cycle for 2 cycles
      ELDataArray(1728:1856,AntSel1) = 0;
      ELDataArray(1728:1856,AntSel2) = 1;
      ELDataArray(1728:1856,AntSel3) = 0;      
      %Antenna select read
      ELDataArray(1728:1792,AntSelRd) = 1;
      
      %to scan this handles everything from the start of the TO scan to the
      %end of the FRO scan
      ELDataArray(1856:5356,AntSel1) = 1;
      ELDataArray(1856:5356,AntSel2) = 0;
      ELDataArray(1856:5356,AntSel3) = 1;
      %SBstart along with the to/fro
      ELDataArray(1856:3406,ToFro) = 1;
      ELDataArray(1856:3406,SBstart) = 1;
      %Antenna select read
      ELDataArray(1856:1920,AntSelRd) = 1;
      
      %pause starting at 3.406 ms and he FRO scan starts at 3.806 (skipping
      %midscan point
      ELDataArray(3407:3805,TxEn) = 0;
      
      %FRO scan 
      ELDataArray(3806:5356,ToFro) = 0;
      ELDataArray(3806:5356,SBstart) = 1;
      
      
      %end function since the SB stopps and goes to 0 then AntSelRd goes
      %high for one clock cycle
      ELDataArray(5356:5429,AntSelRd) = 1;
      
   end
   
   
   function BD1DataArray = FunctionBD1(~)

        TxEn = 1;
        BPSK = 2;
        AntSelRd = 8;

  %stuff for BD1 or basic data word 1 
      BD1DataArray(3100,8) = 0;
      for i = 1:831
      BD1DataArray(i,BPSK) = 0;%carrier acquisition
      end 
      
      for i = 1:2880
      BD1DataArray(i,TxEn) = 1;%sets enable high for the entire 2d array. will be set low when it needs to be 
      end 
      
       for i = 1:64
           BD1DataArray(i,AntSelRd) = 1;
      end

      
      %these are for the time sync first 5 bits maybe
      BD1DataArray(832:896,BPSK) = 1;
      BD1DataArray(896:960,BPSK) = 1;
      BD1DataArray(960:1024,BPSK) = 1;
      BD1DataArray(1024:1088,BPSK) = 0;
      BD1DataArray(1088:1152,BPSK) = 1;
      %function ID for BAZ 
      BD1DataArray(1152:1216,BPSK) = 0;
      BD1DataArray(1216:1280,BPSK) = 1;
      BD1DataArray(1280:1344,BPSK) = 0;
      BD1DataArray(1344:1408,BPSK) = 1;
      BD1DataArray(1408:1472,BPSK) = 0;
      BD1DataArray(1472:1536,BPSK) = 0;
      BD1DataArray(1536:1600,BPSK) = 0;
      
      %10111100111001011111 Given Basic data word 1 
      %here starts the basic data word 1 Data Transmission 
      BD1DataArray(1600:1644,BPSK) = 1;
      BD1DataArray(1644:1728,BPSK) = 0;
      BD1DataArray(1728:1792,BPSK) = 1;
      BD1DataArray(1792:1856,BPSK) = 1;
      BD1DataArray(1856:1920,BPSK) = 1;
      BD1DataArray(1920:1984,BPSK) = 1;
      BD1DataArray(1984:2048,BPSK) = 0;
      BD1DataArray(2048:2112,BPSK) = 0;
      BD1DataArray(2112:2176,BPSK) = 1;
      BD1DataArray(2176:2240,BPSK) = 1;
      BD1DataArray(2240:2304,BPSK) = 1;
      BD1DataArray(2304:2368,BPSK) = 0;
      BD1DataArray(2368:2432,BPSK) = 0;
      BD1DataArray(2432:2496,BPSK) = 1;
      BD1DataArray(2496:2560,BPSK) = 0;
      BD1DataArray(2560:2624,BPSK) = 1;
      BD1DataArray(2624:2688,BPSK) = 1;
      BD1DataArray(2688:2752,BPSK) = 1;
      BD1DataArray(2752:2816,BPSK) = 1;
      BD1DataArray(2861:2880,BPSK) = 1;
      %end of the basic data bits      
      
end 
        
function BD2DataArray = FunctionBD2(~)


        TxEn = 1;
        BPSK = 2;
        AntSelRd = 8;
        

  %stuff for BD2 or basic data word 2
      BD2DataArray(3100,8) = 0;
      for i = 1:831
      BD2DataArray(i,BPSK) = 0;%carrier acquisition
      end 
      
      for i = 1:2880
      BD2DataArray(i,TxEn) = 1;%sets enable high for the entire 2d array. will be set low when it needs to be 
      end 
      for i = 1:64
           BD2DataArray(i,AntSelRd) = 1;
      end

      
      %these are for the time sync first 5 bits maybe
      %111010111100
      BD2DataArray(832:896,BPSK) = 1;
      BD2DataArray(896:960,BPSK) = 1;
      BD2DataArray(960:1024,BPSK) = 1;
      BD2DataArray(1024:1088,BPSK) = 0;
      BD2DataArray(1088:1152,BPSK) = 1;
      %function ID 
      BD2DataArray(1152:1216,BPSK) = 0;
      BD2DataArray(1216:1280,BPSK) = 1;
      BD2DataArray(1280:1344,BPSK) = 1;
      BD2DataArray(1344:1408,BPSK) = 1;
      BD2DataArray(1408:1472,BPSK) = 1;
      BD2DataArray(1472:1536,BPSK) = 0;
      BD2DataArray(1536:1600,BPSK) = 0;
      
      %10000110010010100100 Given Basic data word 2
      %here starts the basic data word 2 Data Transmission 
      BD2DataArray(1600:1644,BPSK) = 1;
      BD2DataArray(1644:1728,BPSK) = 0;
      BD2DataArray(1728:1792,BPSK) = 0;
      BD2DataArray(1792:1856,BPSK) = 0;
      BD2DataArray(1856:1920,BPSK) = 0;
      BD2DataArray(1920:1984,BPSK) = 1;
      BD2DataArray(1984:2048,BPSK) = 1;
      BD2DataArray(2048:2112,BPSK) = 0;
      BD2DataArray(2112:2176,BPSK) = 0;
      BD2DataArray(2176:2240,BPSK) = 1;
      BD2DataArray(2240:2304,BPSK) = 0;
      BD2DataArray(2304:2368,BPSK) = 0;
      BD2DataArray(2368:2432,BPSK) = 1;
      BD2DataArray(2432:2496,BPSK) = 0;
      BD2DataArray(2496:2560,BPSK) = 1;
      BD2DataArray(2560:2624,BPSK) = 0;
      BD2DataArray(2624:2688,BPSK) = 0;
      BD2DataArray(2688:2752,BPSK) = 1;
      BD2DataArray(2752:2816,BPSK) = 0;
      BD2DataArray(2861:2880,BPSK) = 0;
      %end of the basic data bits

end 

function BD3DataArray = FunctionBD3(~)

        TxEn = 1;
        BPSK = 2;
        AntSelRd = 8;

  %stuff for BD3 or basic data word 3
      BD3DataArray(3100,8) = 0;
      for i = 1:831
      BD3DataArray(i,BPSK) = 0;%carrier acquisition
      end 
      
      for i = 1:2880
      BD3DataArray(i,TxEn) = 1;%sets enable high for the entire 2d array. will be set low when it needs to be 
      end 

            for i = 1:64
           BD3DataArray(i,AntSelRd) = 1;
      end
      %these are for the time sync first 5 bits maybe
      %11101 1010000
      BD3DataArray(832:896,BPSK) = 1;
      BD3DataArray(896:960,BPSK) = 1;
      BD3DataArray(960:1024,BPSK) = 1;
      BD3DataArray(1024:1088,BPSK) = 0;
      BD3DataArray(1088:1152,BPSK) = 1;
      %function ID 
      BD3DataArray(1152:1216,BPSK) = 1;
      BD3DataArray(1216:1280,BPSK) = 0;
      BD3DataArray(1280:1344,BPSK) = 1;
      BD3DataArray(1344:1408,BPSK) = 0;
      BD3DataArray(1408:1472,BPSK) = 0;
      BD3DataArray(1472:1536,BPSK) = 0;
      BD3DataArray(1536:1600,BPSK) = 0;
      
      %11100101101011011000 Given Basic data word 3
      %here starts the basic data word 3 Data Transmission 
      BD3DataArray(1600:1644,BPSK) = 1;
      BD3DataArray(1644:1728,BPSK) = 1;
      BD3DataArray(1728:1792,BPSK) = 1;
      BD3DataArray(1792:1856,BPSK) = 0;
      BD3DataArray(1856:1920,BPSK) = 0;
      BD3DataArray(1920:1984,BPSK) = 1;
      BD3DataArray(1984:2048,BPSK) = 0;
      BD3DataArray(2048:2112,BPSK) = 1;
      BD3DataArray(2112:2176,BPSK) = 1;
      BD3DataArray(2176:2240,BPSK) = 0;
      BD3DataArray(2240:2304,BPSK) = 1;
      BD3DataArray(2304:2368,BPSK) = 0;
      BD3DataArray(2368:2432,BPSK) = 1;
      BD3DataArray(2432:2496,BPSK) = 1;
      BD3DataArray(2496:2560,BPSK) = 0;
      BD3DataArray(2560:2624,BPSK) = 1;
      BD3DataArray(2624:2688,BPSK) = 1;
      BD3DataArray(2688:2752,BPSK) = 0;
      BD3DataArray(2752:2816,BPSK) = 0;
      BD3DataArray(2861:2880,BPSK) = 0;
      %end of the basic data bits
      
end 

function BD4DataArray = FunctionBD4(~)

        TxEn = 1;
        BPSK = 2;
        AntSelRd = 8;

  %stuff for BD4 or basic data word 4
      BD4DataArray(3100,8) = 0;
      for i = 1:831
      BD4DataArray(i,BPSK) = 0;%carrier acquisition
      end 
      
      for i = 1:2880
      BD4DataArray(i,TxEn) = 1;%sets enable high for the entire 2d array. will be set low when it needs to be 
      end 

            for i = 1:64
           BD4DataArray(i,AntSelRd) = 1;
      end
      %these are for the time sync first 5 bits maybe
      %11101 1000100
      BD4DataArray(832:896,BPSK) = 1;
      BD4DataArray(896:960,BPSK) = 1;
      BD4DataArray(960:1024,BPSK) = 1;
      BD4DataArray(1024:1088,BPSK) = 0;
      BD4DataArray(1088:1152,BPSK) = 1;
      %function ID 
      BD4DataArray(1152:1216,BPSK) = 1;
      BD4DataArray(1216:1280,BPSK) = 0;
      BD4DataArray(1280:1344,BPSK) = 0;
      BD4DataArray(1344:1408,BPSK) = 0;
      BD4DataArray(1408:1472,BPSK) = 1;
      BD4DataArray(1472:1536,BPSK) = 0;
      BD4DataArray(1536:1600,BPSK) = 0;
      
      %11110010111001010101 Given Basic data word 4
      %here starts the basic data word 4 Data Transmission 
      BD4DataArray(1600:1644,BPSK) = 1;
      BD4DataArray(1644:1728,BPSK) = 1;
      BD4DataArray(1728:1792,BPSK) = 1;
      BD4DataArray(1792:1856,BPSK) = 1;
      BD4DataArray(1856:1920,BPSK) = 0;
      BD4DataArray(1920:1984,BPSK) = 0;
      BD4DataArray(1984:2048,BPSK) = 1;
      BD4DataArray(2048:2112,BPSK) = 0;
      BD4DataArray(2112:2176,BPSK) = 1;
      BD4DataArray(2176:2240,BPSK) = 1;
      BD4DataArray(2240:2304,BPSK) = 1;
      BD4DataArray(2304:2368,BPSK) = 0;
      BD4DataArray(2368:2432,BPSK) = 0;
      BD4DataArray(2432:2496,BPSK) = 1;
      BD4DataArray(2496:2560,BPSK) = 0;
      BD4DataArray(2560:2624,BPSK) = 1;
      BD4DataArray(2624:2688,BPSK) = 0;
      BD4DataArray(2688:2752,BPSK) = 1;
      BD4DataArray(2752:2816,BPSK) = 0;
      BD4DataArray(2861:2880,BPSK) = 1;
      %end of the basic data bits
end 

function BD5DataArray = FunctionBD5(~)

        TxEn = 1;
        BPSK = 2;
        AntSelRd = 8;

  %stuff for BD5 or basic data word 5
      BD5DataArray(3100,8) = 0;
      for i = 1:831
      BD5DataArray(i,BPSK) = 0;%carrier acquisition
      end 
      
      for i = 1:2880
      BD5DataArray(i,TxEn) = 1;%sets enable high for the entire 2d array. will be set low when it needs to be 
      end 

            for i = 1:64
           BD5DataArray(i,AntSelRd) = 1;
      end
      %these are for the time sync first 5 bits maybe
      %11101 1101100
      BD5DataArray(832:896,BPSK) = 1;
      BD5DataArray(896:960,BPSK) = 1;
      BD5DataArray(960:1024,BPSK) = 1;
      BD5DataArray(1024:1088,BPSK) = 0;
      BD5DataArray(1088:1152,BPSK) = 1;
      %function ID 
      BD5DataArray(1152:1216,BPSK) = 1;
      BD5DataArray(1216:1280,BPSK) = 1;
      BD5DataArray(1280:1344,BPSK) = 0;
      BD5DataArray(1344:1408,BPSK) = 1;
      BD5DataArray(1408:1472,BPSK) = 1;
      BD5DataArray(1472:1536,BPSK) = 0;
      BD5DataArray(1536:1600,BPSK) = 0;
      
      %01110011011010011010 Given Basic data word 5
      %here starts the basic data word 5 Data Transmission 
      BD5DataArray(1600:1644,BPSK) = 0;
      BD5DataArray(1644:1728,BPSK) = 1;
      BD5DataArray(1728:1792,BPSK) = 1;
      BD5DataArray(1792:1856,BPSK) = 1;
      BD5DataArray(1856:1920,BPSK) = 0;
      BD5DataArray(1920:1984,BPSK) = 0;
      BD5DataArray(1984:2048,BPSK) = 1;
      BD5DataArray(2048:2112,BPSK) = 1;
      BD5DataArray(2112:2176,BPSK) = 0;
      BD5DataArray(2176:2240,BPSK) = 1;
      BD5DataArray(2240:2304,BPSK) = 1;
      BD5DataArray(2304:2368,BPSK) = 0;
      BD5DataArray(2368:2432,BPSK) = 1;
      BD5DataArray(2432:2496,BPSK) = 0;
      BD5DataArray(2496:2560,BPSK) = 0;
      BD5DataArray(2560:2624,BPSK) = 1;
      BD5DataArray(2624:2688,BPSK) = 1;
      BD5DataArray(2688:2752,BPSK) = 0;
      BD5DataArray(2752:2816,BPSK) = 1;
      BD5DataArray(2861:2880,BPSK) = 0;
      %end of the basic data bits

end 


function BD6DataArray = FunctionBD6(~)

        TxEn = 1;
        BPSK = 2;
        AntSelRd = 8;

  %stuff for BD6 or basic data word 6
      BD6DataArray(3100,8) = 0;
      for i = 1:831
      BD6DataArray(i,BPSK) = 0;%carrier acquisition
      end 
      
      for i = 1:2880
      BD6DataArray(i,TxEn) = 1;%sets enable high for the entire 2d array. will be set low when it needs to be 
      end 

            for i = 1:64
           BD6DataArray(i,AntSelRd) = 1;
      end
      %these are for the time sync first 5 bits maybe
      %11101 0001101
      BD6DataArray(832:896,BPSK) = 1;
      BD6DataArray(896:960,BPSK) = 1;
      BD6DataArray(960:1024,BPSK) = 1;
      BD6DataArray(1024:1088,BPSK) = 0;
      BD6DataArray(1088:1152,BPSK) = 1;
      %function ID 
      BD6DataArray(1152:1216,BPSK) = 0;
      BD6DataArray(1216:1280,BPSK) = 0;
      BD6DataArray(1280:1344,BPSK) = 0;
      BD6DataArray(1344:1408,BPSK) = 1;
      BD6DataArray(1408:1472,BPSK) = 1;
      BD6DataArray(1472:1536,BPSK) = 0;
      BD6DataArray(1536:1600,BPSK) = 1;
      
      %10000000001010000110 Given Basic data word 6
      %here starts the basic data word 6 Data Transmission 
      BD6DataArray(1600:1644,BPSK) = 1;
      BD6DataArray(1644:1728,BPSK) = 0;
      BD6DataArray(1728:1792,BPSK) = 0;
      BD6DataArray(1792:1856,BPSK) = 0;
      BD6DataArray(1856:1920,BPSK) = 0;
      BD6DataArray(1920:1984,BPSK) = 0;
      BD6DataArray(1984:2048,BPSK) = 0;
      BD6DataArray(2048:2112,BPSK) = 0;
      BD6DataArray(2112:2176,BPSK) = 0;
      BD6DataArray(2176:2240,BPSK) = 0;
      BD6DataArray(2240:2304,BPSK) = 1;
      BD6DataArray(2304:2368,BPSK) = 0;
      BD6DataArray(2368:2432,BPSK) = 1;
      BD6DataArray(2432:2496,BPSK) = 0;
      BD6DataArray(2496:2560,BPSK) = 0;
      BD6DataArray(2560:2624,BPSK) = 0;
      BD6DataArray(2624:2688,BPSK) = 0;
      BD6DataArray(2688:2752,BPSK) = 1;
      BD6DataArray(2752:2816,BPSK) = 1;
      BD6DataArray(2861:2880,BPSK) = 0;
      %end of the basic data bits
end 

% aux data word 
function ADADataArray = FunctionADA(~)
     TxEn = 1;
     BPSK = 2;
        AntSelRd = 8;
        ADADataArray(5900,8) = 0;
  %stuff for BD6 or basic data word 6
      ADADataArray(5900,8) = 0;
      for i = 1:831
      ADADataArray(i,BPSK) = 0;%carrier acquisition
      end 
      
      for i = 1:5696
      ADADataArray(i,TxEn) = 1;%sets enable high for the entire 2d array. will be set low when it needs to be 
      end 

            for i = 1:64
           ADADataArray(i,AntSelRd) = 1;
      end
      %these are for the time sync first 5 bits maybe
      %11101 1110010
      ADADataArray(832:896,BPSK) = 1;
      ADADataArray(896:960,BPSK) = 1;
      ADADataArray(960:1024,BPSK) = 1;
      ADADataArray(1024:1088,BPSK) = 0;
      ADADataArray(1088:1152,BPSK) = 1;
      %function ID 
      ADADataArray(1152:1216,BPSK) = 1;
      ADADataArray(1216:1280,BPSK) = 1;
      ADADataArray(1280:1344,BPSK) = 1;
      ADADataArray(1344:1408,BPSK) = 0;
      ADADataArray(1408:1472,BPSK) = 0;
      ADADataArray(1472:1536,BPSK) = 1;
      ADADataArray(1536:1600,BPSK) = 0;
      %00001111 Address 
      %1001101000000011100111111111100100010110001100111 data 
      %1000000 parity 
      %Address transmission
      ADADataArray(1600:1644,BPSK) = 0;
      ADADataArray(1644:1728,BPSK) = 0;
      ADADataArray(1728:1792,BPSK) = 0;
      ADADataArray(1792:1856,BPSK) = 0;
      ADADataArray(1856:1920,BPSK) = 1;
      ADADataArray(1920:1984,BPSK) = 1;
      ADADataArray(1984:2048,BPSK) = 1;
      ADADataArray(2048:2112,BPSK) = 1;
      %Data Tranmission 49 bits
      ADADataArray(2112:2176,BPSK) = 1;
      ADADataArray(2176:2240,BPSK) = 0;
      ADADataArray(2240:2304,BPSK) = 0;
      ADADataArray(2304:2368,BPSK) = 1;
      ADADataArray(2368:2432,BPSK) = 1;
      ADADataArray(2432:2496,BPSK) = 0;
      ADADataArray(2496:2560,BPSK) = 1;
      ADADataArray(2560:2624,BPSK) = 0;
      ADADataArray(2624:2688,BPSK) = 0;
      ADADataArray(2688:2752,BPSK) = 0;
      ADADataArray(2752:2816,BPSK) = 0;
      ADADataArray(2861:2880,BPSK) = 0;
      ADADataArray(2880:2944,BPSK) = 0;
      ADADataArray(2944:3008,BPSK) = 0;
      ADADataArray(3008:3072,BPSK) = 1;
      ADADataArray(3072:3136,BPSK) = 1;
      ADADataArray(3136:3200,BPSK) = 1;
      ADADataArray(3200:3264,BPSK) = 0;
      ADADataArray(3264:3328,BPSK) = 0;
      ADADataArray(3328:3392,BPSK) = 1;
      ADADataArray(3392:3456,BPSK) = 1;
      ADADataArray(3456:3520,BPSK) = 1;
      ADADataArray(3520:3584,BPSK) = 1;
      ADADataArray(3584:3648,BPSK) = 1;
      ADADataArray(3648:3712,BPSK) = 1;
      ADADataArray(3712:3776,BPSK) = 1;
      ADADataArray(3776:3840,BPSK) = 1;
      ADADataArray(3840:3904,BPSK) = 1;
      ADADataArray(3904:3968,BPSK) = 1;
      ADADataArray(3968:4032,BPSK) = 0;
      ADADataArray(4032:4096,BPSK) = 0;
      ADADataArray(4096:4160,BPSK) = 1;
      ADADataArray(4160:4224,BPSK) = 0;
      ADADataArray(4224:4288,BPSK) = 0;
      ADADataArray(4288:4352,BPSK) = 0;
      ADADataArray(4352:4416,BPSK) = 1;
      ADADataArray(4416:4480,BPSK) = 0;
      ADADataArray(4480:4544,BPSK) = 1;
      ADADataArray(4544:4608,BPSK) = 1;
      ADADataArray(4608:4672,BPSK) = 0;
      ADADataArray(4672:4736,BPSK) = 0;
      ADADataArray(4736:4800,BPSK) = 0;
      ADADataArray(4800:4864,BPSK) = 1;
      ADADataArray(4864:4928,BPSK) = 1;
      ADADataArray(4928:4992,BPSK) = 0;
      ADADataArray(4992:5056,BPSK) = 0;
      ADADataArray(5056:5120,BPSK) = 1;
      ADADataArray(5120:5184,BPSK) = 1;
      ADADataArray(5184:5248,BPSK) = 1;
      %parity bits 
      ADADataArray(5248:5312,BPSK) = 1;
      ADADataArray(5312:5376,BPSK) = 0;
      ADADataArray(5376:5440,BPSK) = 0;
      ADADataArray(5440:5504,BPSK) = 0;
      ADADataArray(5504:5568,BPSK) = 0;
      ADADataArray(5568:5632,BPSK) = 0;
      ADADataArray(5632:5696,BPSK) = 0;
      
      
end 
