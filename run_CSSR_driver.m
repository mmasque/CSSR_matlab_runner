

load("example_dataset.mat");
complexities = [];
timestamps = [];
for i = 2:9
    tic
    complexities = [complexities run_CSSR(DATA, "binary01-alphabet.txt", i, "face_nonface_together", true)];
    td = toc;
    timestamps = [timestamps td];
end

plot(2:9, timestamps)
