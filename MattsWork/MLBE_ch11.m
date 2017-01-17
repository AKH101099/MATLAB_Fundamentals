S.mass = 0.938
S.primenumbers = [2 3 5 7]
S.smartcreatures = {'elephants','parrots','humans'}

S.self = S

S = rmfield(S,'mass')


mymodel = struct('datafile','elec_res.xlsx','polydegree',3,'predictdate', ...
    datetime(2020,1,1),'monthavg',12,'nummonthmodel',120,'makeplot',true)

pred = analysis_struct(mymodel)