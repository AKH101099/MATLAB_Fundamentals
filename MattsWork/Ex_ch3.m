load cassiniData1.mat
plot(Time,Radius,'m:')
xlabel('Time')
ylabel('Radius [AU]')

hold on
plot(Time1,Radius1,'ro')


[g,idx] = max(Radius)
Timeg = Time(idx)

plot(Timeg,g,'gx')
hold off