%%
%% coding by microy
%%
clc;close all;
clear

CALLi = dec2bin(hex2dec('1'),8);        %01ii
GOTOi = dec2bin(hex2dec('2'),8);        %02ii

ADDi  = dec2bin(hex2dec('3'),4);        %xkii
ANDi  = dec2bin(hex2dec('4'),4);        %xkii
ORi   = dec2bin(hex2dec('5'),4);        %xkii
XORi  = dec2bin(hex2dec('6'),4);        %xkii
LDi   = dec2bin(hex2dec('7'),4);        %xkii
LDip  = dec2bin(hex2dec('C'),4);        %xkii
STip  = dec2bin(hex2dec('D'),4);        %xiik
LDp   = dec2bin(hex2dec('E'),4);        %xkmg
STp   = dec2bin(hex2dec('F'),4);        %xkmg

%8km3
ADD   = dec2bin(hex2dec('8'),4);iadd = dec2bin(hex2dec('3'),4);        
%8km4                                
AND   = dec2bin(hex2dec('8'),4);iand = dec2bin(hex2dec('4'),4);       
%8km5                                
OR    = dec2bin(hex2dec('8'),4);ior  = dec2bin(hex2dec('5'),4);        
%8km6                                
XOR   = dec2bin(hex2dec('8'),4);ixor = dec2bin(hex2dec('6'),4);        
%8km7                                
MOV   = dec2bin(hex2dec('8'),4);imov = dec2bin(hex2dec('7'),4);        
%8kmA
LSR   = dec2bin(hex2dec('8'),4);ilsr = dec2bin(hex2dec('A'),4);
%8kmB        
ASR   = dec2bin(hex2dec('8'),4);iasr = dec2bin(hex2dec('B'),4); 
%8kmE
EQSN  = dec2bin(hex2dec('8'),4);ieqsn= dec2bin(hex2dec('E'),4); 
%9ii3
DHi   = dec2bin(hex2dec('9'),4);idhi = dec2bin(hex2dec('3'),4);      
RET   = dec2bin(hex2dec('9000'),16);    %9000

PC    = dec2bin(hex2dec('0'),4);
SP    = dec2bin(hex2dec('1'),4);
ST    = dec2bin(hex2dec('2'),4);
MAP   = dec2bin(hex2dec('3'),4);       %reserved
GP4   = dec2bin(hex2dec('4'),4);
GP5   = dec2bin(hex2dec('5'),4);
GP6   = dec2bin(hex2dec('6'),4);
GP7   = dec2bin(hex2dec('7'),4);
GP8   = dec2bin(hex2dec('8'),4);
GP9   = dec2bin(hex2dec('9'),4);
GPA   = dec2bin(hex2dec('A'),4);
GPB   = dec2bin(hex2dec('B'),4);
GPC   = dec2bin(hex2dec('C'),4);
GPD   = dec2bin(hex2dec('D'),4);
GPE   = dec2bin(hex2dec('E'),4);
GPF   = dec2bin(hex2dec('F'),4);

hexcode = zeros(1,256)';
hexcode = dec2bin(hexcode,16);

Inst_NOP = [MOV MAP MAP imov];

count = 1;
x=DHi;  ii = dec2bin(hex2dec('aa'),8);       %dhi 88
hexcode(count,:) = [x ii idhi];count = count+1;
x=ADDi;  kreg  = GP4; ii = dec2bin(hex2dec('aa'),8);   %addi gp4, aaaa
hexcode(count,:) = [x kreg ii];count = count+1;

x=ADDi;  kreg  = GP5; ii = dec2bin(50,8);   %addi gp5, 50
hexcode(count,:) = [x kreg ii];count = count+1;

x=STip;  kreg  = GP4;ii = dec2bin(hex2dec('50'),8); %STip *0x50,GP4 --> (*0x50) = 0xaaaa
hexcode(count,:) = [x kreg ii];count = count+1;    
hexcode(count,:) = Inst_NOP;count = count+1;        % nop
x=LDip;  kreg  = GPF; ii = dec2bin(hex2dec('50'),8);%LDip GPF,*0x50 --> GPF=(*0x50)=aaaa
hexcode(count,:) = [x kreg ii ];count = count+1; 
hexcode(count,:) = Inst_NOP;count = count+1;        % nop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Label_Delay = count + 100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=CALLi; ii= dec2bin(Label_Delay,8);              %CALLi delay
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop
x=CALLi; ii= dec2bin(Label_Delay,8);              %CALLi delay
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop
x=CALLi; ii= dec2bin(Label_Delay,8);              %CALLi delay
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

x=STp;   mreg = GP4; kreg = GP5; g = dec2bin(0,4);  %STp *GP4 GP5 --> (*GP4)=(*0x28)=50
hexcode(count,:) = [x kreg mreg  g];count = count+1;   
hexcode(count,:) = Inst_NOP;count = count+1;        % nop
x=LDp;   kreg = GP4; mreg = GP4; g = dec2bin(0,4);  %LDp GP4 *GP4 --> GP4=(*0x28)=50 
hexcode(count,:) = [x kreg mreg g];count = count+1;   
hexcode(count,:) = Inst_NOP;count = count+1;        % nop
x=MOV;  kreg  = GPF; mreg = GP4;             % mov gp6, gp4
hexcode(count,:) = [x kreg mreg imov];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

x=MOV;  kreg  = GP6; mreg = GP4;             % mov gp6, gp4
hexcode(count,:) = [x kreg mreg imov];count = count+1;
x=MOV;  kreg  = GP7; mreg = GP5;             % mov gp7, gp5
hexcode(count,:) = [x kreg mreg imov];count = count+1;
x=MOV;  kreg  = GP8; mreg = GP7;             % mov gp8, gp7
hexcode(count,:) = [x kreg mreg imov];count = count+1;

x=ADD;  kreg  = GP4; mreg = GP7;             % add gp4, gp7
hexcode(count,:) = [x kreg mreg iadd];count = count+1;
x=LSR;  kreg  = GP6; mreg = dec2bin(2,4);    % lsr gp6, 2
hexcode(count,:) = [x kreg mreg ilsr];count = count+1;
x=ASR;  kreg  = GP8; mreg = dec2bin(2,4);    % asr gp8, 2
hexcode(count,:) = [x kreg mreg iasr];count = count+1;
x=ADDi;  kreg  = GP5; ii = dec2bin(50,8);    % addi gp5,50
hexcode(count,:) = [x kreg ii];count = count+1;

x=DHi;  ii = dec2bin(hex2dec('88'),8);       %dhi 88
hexcode(count,:) = [x ii idhi];count = count+1;
x=LDi;  kreg = GPA; ii = dec2bin(hex2dec('AA'),8); %ldi gpa, AA
hexcode(count,:) = [x kreg ii];count = count+1;

x=DHi;  ii = dec2bin(hex2dec('99'),8);             %dhi 99
hexcode(count,:) = [x ii idhi];count = count+1;
x=LDi;  kreg = GPB; ii = dec2bin(hex2dec('bb'),8); %ldi gpb, BB
hexcode(count,:) = [x kreg ii];count = count+1;
%%%----------------------------------%%%
%call delay
% Label_Delay = count + 40;    %CALL Delay
x=CALLi; ii= dec2bin(Label_Delay,8);               %calli Label_Delay            
hexcode(count,:) = [x ii];count = count+1;
fprintf('Label_Delay = %s\n',dec2hex(bin2dec(hexcode(count-1,:)),4));
hexcode(count,:) = Inst_NOP;count = count+1; % nop

x=LSR;  kreg  = GPA; mreg = dec2bin(2,4);    % lsr gpA, 2
hexcode(count,:) = [x kreg mreg ilsr];count = count+1;
x=ASR;  kreg  = GPB; mreg = dec2bin(2,4);    % asr gpB, 2
hexcode(count,:) = [x kreg mreg iasr];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

%loop : goto loop  
Label_LoopGoto = count;
hexcode(count,:) = Inst_NOP;count = count+1; % nop
x=LDi;  kreg = GPF; ii = dec2bin(hex2dec('01'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

x=LDi;  kreg = GPF; ii = dec2bin(hex2dec('02'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

x=LDi;  kreg = GPF; ii = dec2bin(hex2dec('04'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

x=LDi;  kreg = GPF; ii = dec2bin(hex2dec('08'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

x=LDi;  kreg = GPF; ii = dec2bin(hex2dec('10'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

x=LDi;  kreg = GPF; ii = dec2bin(hex2dec('20'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop


x=LDi;  kreg = GPF; ii = dec2bin(hex2dec('40'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop


x=LDi;  kreg = GPF; ii = dec2bin(hex2dec('80'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

% hexcode(count,:) = Inst_NOP;count = count+1; % nop
x=DHi;  ii = dec2bin(hex2dec('01'),8);
hexcode(count,:) = [x ii idhi];count = count+1;
x=LDi;  kreg = GPF; ii = dec2bin(hex2dec('00'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

% hexcode(count,:) = Inst_NOP;count = count+1; % nop
x=DHi;  ii = dec2bin(hex2dec('02'),8);
hexcode(count,:) = [x ii idhi];count = count+1;
x=LDi;  kreg = GPF; ii = dec2bin(hex2dec('00'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

% hexcode(count,:) = Inst_NOP;count = count+1; % nop
x=DHi;  ii = dec2bin(hex2dec('04'),8);
hexcode(count,:) = [x ii idhi];count = count+1;
x=LDi;  kreg = GPF; ii = dec2bin(hex2dec('00'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

% hexcode(count,:) = Inst_NOP;count = count+1; % nop
x=DHi;  ii = dec2bin(hex2dec('08'),8);
hexcode(count,:) = [x ii idhi];count = count+1;
x=LDi;  kreg = GPF; ii = dec2bin(hex2dec('00'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

% hexcode(count,:) = Inst_NOP;count = count+1; % nop
x=DHi;  ii = dec2bin(hex2dec('10'),8);
hexcode(count,:) = [x ii idhi];count = count+1;
x=LDi;  kreg = GPF; ii = dec2bin(hex2dec('00'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

% hexcode(count,:) = Inst_NOP;count = count+1; % nop
x=DHi;  ii = dec2bin(hex2dec('20'),8);
hexcode(count,:) = [x ii idhi];count = count+1;
x=LDi;  kreg = GPF; ii = dec2bin(hex2dec('00'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

% hexcode(count,:) = Inst_NOP;count = count+1; % nop
x=DHi;  ii = dec2bin(hex2dec('40'),8);
hexcode(count,:) = [x ii idhi];count = count+1;
x=LDi;  kreg = GPF; ii = dec2bin(hex2dec('00'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

% hexcode(count,:) = Inst_NOP;count = count+1; % nop
x=DHi;  ii = dec2bin(hex2dec('80'),8);
hexcode(count,:) = [x ii idhi];count = count+1;
x=LDi;  kreg = GPF; ii = dec2bin(hex2dec('00'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
x=CALLi; ii= dec2bin(Label_Delay,8); 
hexcode(count,:) = [x ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

x=GOTOi; ii= dec2bin(Label_LoopGoto,8); 
hexcode(count,:) = [x ii];count = count+1;   % goto loopgoto
fprintf('Label_Goto = %s\n',dec2hex(bin2dec(hexcode(count-1,:)),4));
hexcode(count,:) = Inst_NOP;count = count+1; % nop

%
%-----------------------------------------
% Delay function
%-----------------------------------------
%Label_Delay
count= Label_Delay;
% GPD = 0x0000
x=DHi;  ii = dec2bin(hex2dec('00'),8);
hexcode(count,:) = [x ii idhi];count = count+1;
x=LDi;  kreg = GPD; ii = dec2bin(hex2dec('00'),8);
hexcode(count,:) = [x kreg ii];count = count+1;
% GPC = 0xFFF0
x=DHi;  ii = dec2bin(hex2dec('05'),8);
hexcode(count,:) = [x ii idhi];count = count+1;
x=LDi;  kreg = GPC; ii = dec2bin(hex2dec('00'),8);
hexcode(count,:) = [x kreg ii];count = count+1;  
%%for(i=0;i<GPC;i++)
Lable_dyloop = count;
hexcode(count,:) = Inst_NOP;count = count+1; % nop
x=ADDi;  kreg  = GPD; ii = dec2bin(1,8);
hexcode(count,:) = [x kreg ii];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop
    %%for(j=0;j<GPD;j++)
    x=DHi;  ii = dec2bin(hex2dec('00'),8);
    hexcode(count,:) = [x ii idhi];count = count+1;
    x=LDi;  kreg = GPB; ii = dec2bin(hex2dec('00'),8); 
    hexcode(count,:) = [x kreg ii];count = count+1;
    %%{
    Lable_dyloop_j = count;
    x=ADDi;  kreg  = GPB; ii = dec2bin(1,8);
    hexcode(count,:) = [x kreg ii];count = count+1;
    hexcode(count,:) = Inst_NOP;count = count+1; % nop
    %GPC==GPB equal skip next
    x=EQSN;  kreg  = GPC; mreg = GPB;
    hexcode(count,:) = [x kreg mreg ieqsn];count = count+1;
    hexcode(count,:) = Inst_NOP;count = count+1; % nop
    %%%goto loop_delay_j
    x=GOTOi; ii= dec2bin(Lable_dyloop_j,8); 
    hexcode(count,:) = [x ii];count = count+1;
    fprintf('Lable_dyloop_j = %s\n',dec2hex(bin2dec(hexcode(count-1,:)),4));
    hexcode(count,:) = Inst_NOP;count = count+1; % nop
    %%}
%GPC==GPD equal skip next
x=EQSN;  kreg  = GPC; mreg = GPD;
hexcode(count,:) = [x kreg mreg ieqsn];count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop
%%%goto loop_delay
x=GOTOi; ii= dec2bin(Lable_dyloop,8); 
hexcode(count,:) = [x ii];count = count+1;
fprintf('Lable_dyloop = %s\n',dec2hex(bin2dec(hexcode(count-1,:)),4));
hexcode(count,:) = Inst_NOP;count = count+1; % nop

%%%%RET
hexcode(count,:) = RET;count = count+1;
hexcode(count,:) = Inst_NOP;count = count+1; % nop

%%
%输出为 *.coe文件bin进制输出方式
Timestr = datestr(now,'yyyy-mm-dd HH:MM');
fid = fopen('.\rom_init.coe','wt');
fprintf(fid,';;This *.coe is generated at %s ------\n',Timestr);
clear Timestr;
fprintf(fid,';;------Depth = %d ---\n',256);
fprintf(fid,';;------Width = %d ---\n',16);
fprintf(fid,'memory_initialization_radix=16;\n');
fprintf(fid,'memory_initialization_vector=\n');

hexcode = dec2hex(bin2dec(hexcode),4)';
Inst_NOP = dec2hex(bin2dec(Inst_NOP),4)';
hexcode = [Inst_NOP hexcode];
hexcode = hexcode';
for i=1:count
    if( (hexcode(i,:) ==hexcode(count+1,:)))
        %fprintf(fid,'%s,\n',NOP);
        fprintf(fid,'%s,\n',hexcode(i,:));
    else
        fprintf(fid,'%s,\n',hexcode(i,:));
    end
end
fprintf(fid,'%s;\n',hexcode(count,:)); %多输出一条NOP指令

Timestr = datestr(now,'yyyy-mm-dd HH:MM');
fprintf('finished at %s\n',Timestr);