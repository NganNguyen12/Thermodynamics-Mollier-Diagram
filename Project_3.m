hTsl = [];     %enthalpy of saturated liquid
sTsl = [];     %entropy of saturated liquid
hTsv = [];     %enthalpy of saturated vapour
sTsv = [];     %entropy of saturated vapour

for T=(20:0.05:374)
    %saturated liquid curve
    hTsatliq = SteamIC('hL_T',T);
    sTsatliq = SteamIC('sL_T',T);
    hTsl = [hTsl hTsatliq];
    sTsl = [sTsl sTsatliq];
    
    %saturated vapour curve
    hTsatvap = SteamIC('hV_T',T);
    sTsatvap = SteamIC('sV_T',T);
    hTsv = [hTsv hTsatvap];
    sTsv = [sTsv sTsatvap];
end 

%plotting
figure(1)
plot(sTsl,hTsl, 'r-', 'lineWidth',2)
hold on
plot(sTsv,hTsv,'r-','lineWidth',2)
xlabel('Entropy/kJkg^-1K^-1')
ylabel('Enthalpy/kJkg^-1')
title('h-s diagram for water')
grid on;
grid minor;

%isobar curve
T = linspace(0.1,100,4);

%enthalpy
ib01h = [];     %enthalpy at isobar 0.1 bar
ib33h = [];     %enthalpy at isobar 33 bar
ib66h = [];     %enthalpy at isobar 66 bar
ib100h = [];    %enthalpy at isobar 100 bar

for T = [20:1:1000]
    isobar01h = SteamIC('h_pT',0.1,T);
    isobar33h = SteamIC('h_pT',33.4,T);
    isobar66h = SteamIC('h_pT',66.7,T);
    isobar100h = SteamIC('h_pT',100,T);
    
    ib01h = [ib01h isobar01h];
    ib33h = [ib33h isobar33h];
    ib66h = [ib66h isobar66h];
    ib100h = [ib100h isobar100h];
end 

%entropy
ib01s = [];
ib33s = [];
ib66s = [];
ib100s = [];

for T = [20:1:1000];
    isobar01s = SteamIC('s_pT',0.1,T);
    isobar33s = SteamIC('s_pT',33.4,T);
    isobar66s = SteamIC('s_pT',66.7,T);
    isobar100s = SteamIC('s_pT',100,T);
    
    ib01s = [ib01s isobar01s];
    ib33s = [ib33s isobar33s];
    ib66s = [ib66s isobar66s];
    ib100s = [ib100s isobar100s];
end

plot(ib01s,ib01h,'k-','lineWidth',1)
plot(ib33s,ib33h,'k-','lineWidth',1)
plot(ib66s,ib66h,'k-','lineWidth',1)
plot(ib100s,ib100h,'k-','lineWidth',1)

%isothermal curve
T2 = linspace(100,700,4)

it100h = [];       %enthalpy at isothermal T=100C
it300h = [];       %enthalpy at isothermal T=300C
it500h = [];       %enthalpy at isothermal T=500C
it700h = [];       %enthalpy at isothermal T=700C

for p = [0:0.01:1000]
    isotherm100h = SteamIC('h_pT',p,100);
    isotherm300h = SteamIC('h_pT',p,300);
    isotherm500h = SteamIC('h_pT',p,500);
    isotherm700h = SteamIC('h_pT',p,700);
    
    it100h = [it100h isotherm100h];
    it300h = [it300h isotherm300h];
    it500h = [it500h isotherm500h];
    it700h = [it700h isotherm700h];
end 

it100s = [];       %entropy at isothermal T=100C
it300s = [];       %entropy at isothermal T=300C
it500s = [];       %entropy at isothermal T=500C
it700s = [];       %entropy at isothermal T=700C

for p = [0:0.01:1000]
    isotherm100s = SteamIC('s_pT',p,100);
    isotherm300s = SteamIC('s_pT',p,300);
    isotherm500s = SteamIC('s_pT',p,500);
    isotherm700s = SteamIC('s_pT',p,700);
    
    it100s = [it100s isotherm100s];
    it300s = [it300s isotherm300s];
    it500s = [it500s isotherm500s];
    it700s = [it700s isotherm700s];
end 

plot(it100s,it100h,'b-','lineWidth',1.5) 
plot(it300s,it300h,'b-','lineWidth',1.5) 
plot(it500s,it500h,'b-','lineWidth',1.5) 
plot(it700s,it700h,'b-','lineWidth',1.5) 

%% Lines of constant quality 
% lines with quality of x=0.25, x=0.5, x=0.75

x25h=[]; x50h=[]; x75h=[];

for T=[20:0.05:374];
    q25h=SteamIC('h_Tx',T,0.25);
    x25h=[x25h q25h];
    
    q50h=SteamIC('h_Tx',T,0.5);
    x50h=[x50h q50h];
    
    q75h=SteamIC('h_Tx',T,0.75);
    x75h=[x75h q75h];
end
    
x25s=[]; x50s=[]; x75s=[];

x25s=(0.25*sTsv)+((1-0.25)*sTsl);
x50s=(0.5*sTsv)+((1-0.5)*sTsl);
x75s=(0.75*sTsv)+((1-0.75)*sTsl);

%plotting the quality lines 
plot(x25s,x25h, 'g-','lineWidth',1.5) 
plot(x50s,x50h, 'g-','lineWidth',1.5) 
plot(x75s,x75h, 'g-','lineWidth',1.5) 



    
    



