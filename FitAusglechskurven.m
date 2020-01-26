%Fitten vkrit

l =  [26 30:5:100];
v =l';
t = [26: 1: 100];
load Workspace_Vkrit_o.mat;


FigPolyfitVkrit = figure ('Position', [10 10 900 500]);

SubPEdg = subplot(1, 3, 2);
plot(v, Edg, 'xk', 'linewidth', 1);
hold on

B=v.^2\Edg;
RegEdg = linspace(min(v),max(v));
polEdg = RegEdg.^2*B;
plot(RegEdg, polEdg,'-r','linewidth', 1);
hold on
 
pEdg=polyfit(v.^2,Edg,1);
a=pEdg(1);
c=pEdg(2);
pEdgplot = t.^2 *a+c;
plot (t, pEdgplot, 'b', 'linewidth', 1);


xlabel('Windgeschwindigkeit \itv_w \rmin m s^{-1}');
ylabel('Edgewise-Moment in \itN m');
leg = legend ('Mittelwerte Edgewise-Moment', 'Ausgleichskurve \itEdgewise\rm-Moment \newlineax^2', 'Ausgleichskurve \itEdgewise\rm-Moment \newlineax^2+b','location', 'northoutside');   %'Ausgleichskurve \itEdgewise\rm-Moment'
set(leg);
set(gca,'fontsize',10);

posEdg = get(SubPEdg,'Position');
set(SubPEdg,'Position',[posEdg(1) posEdg(2) posEdg(3) 0.8*posEdg(4)]);


SubPFlp = subplot(1, 3, 1);

plot(v, Flp, 'xk', 'linewidth', 1);
hold on

pFlp = polyfit(v,Flp,3);
polyvalFlp = polyval(pFlp,t);
% eqString = [num2str(pFlp(1)) '* v^3 +' num2str(pFlp(2))  ' * v^2 ' num2str(pFlp(3)) ' * v +' num2str(pFlp(4))];
plot(t,polyvalFlp,'r', 'linewidth', 1);

xlabel('Windgeschwindigkeit \itv_w \rmin m s^{-1}');
ylabel('Flapwise-Moment in \itN m');
leg = legend ('Mittelwerte Flapwise-Moment','Ausgleichskurve \itFlapwise\rm-Moment \newlineax^3+bx^2+cx+d','location', 'northoutside');     %'Ausgleichskurve \itFlapwise\rm-Moment',
set(leg);
set(gca,'fontsize',10);

posFlp = get(SubPFlp,'Position');
set(SubPFlp,'Position',[posFlp(1) posFlp(2) posEdg(3) 0.8*posEdg(4)]);


SubPKipp = subplot(1, 3, 3);

plot(v, Kipp, 'xk', 'linewidth', 1);
hold on

H=v.^2\Kipp;
RegKipp = linspace(min(v),max(v));
polKipp = RegKipp.^2*H;
plot(RegKipp, polKipp,'r', 'linewidth', 1);
hold on
H

% pKipp=polyfit(v.^2,Kipp,1);
% a=pKipp(1);
% c=pKipp(2);
% pKippplot = t.^2 *a+c;
% plot (t, pKippplot, 'r','linewidth', 1)
% eqString = [num2str(pKipp(1)) '* v^2'];
% hold on 

xlabel('Windgeschwindigkeit \itv_w \rmin m s^{-1}');
ylabel('Kippmoment in \itN m');
leg = legend ('Mittelwerte Kippmoment','Ausgleichskurve Kippmoment \newlineax^2', 'location', 'northoutside');     %,'Ausgleichskurve Kippmoment'
set(leg);
set(gca,'fontsize',10);
posKipp = get(SubPKipp,'Position');
set(SubPKipp,'Position',[posKipp(1) posKipp(2) posEdg(3) 0.8*posEdg(4)]);








