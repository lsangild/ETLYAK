clear all

k = DriveUnit();
% setParameters(Qts, Bl, Rms, Mms, Cms, Sd, Re, Rnom, fs)
k.setParameters(0.66, 5.1, 0.6, 7e-3, 1.45e-3, 5.4, 5.6, 8, 50);

k.plotResponse(logspace(0,4,100));

%%
u = Cabinet(8e7);
u.setDriveUnit(k);
u.plotResponse(logspace(1,3,100));

%%
cf = CrossoverFilter();
% setBehaviour(f1, f2, order, type)
cf.setBehaviour(500, 3, 'low');
cf.plotResponse(logspace(1, 4, 100));

%%
sp = Speaker();
set(sp, 'filter', cf);
set(sp, 'cabinet', u);
sp.plotResponse(logspace(1, 3, 100));