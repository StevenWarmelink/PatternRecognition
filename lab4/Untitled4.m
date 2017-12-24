%%
clear all;
%%
classA = load('C:\Users\arjun\Desktop\PatternRecognition\labAssignment5\data_lvq_A')
classB = load('C:\Users\arjun\Desktop\PatternRecognition\labAssignment5\data_lvq_B')
classA = classA.matA;
classB = classB.matB;
%%
hold on
scatter(classA(:,1),classA(:,2))
scatter(classB(:,1),classB(:,2))
hold off
%%
[x,t] = classB;
net = lvqnet(10);
net.trainParam.epochs = 50;
net = train(net,x,t);
view(net)
y = net(x);
perf = perform(net,y,t)
classes = vec2ind(y);