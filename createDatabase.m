function [ ] = createDatabase( images_folder )

    files = dir(fullfile(images_folder, '*.jpg'));
    files = {files.name}';

    % Loop image directory and store in matrix
    for i=1:numel(files)
        fname = fullfile(images_folder, files{i});
        disp(['Loading ', num2str(fname), '..'])
        img = imread(fname);
        
        img = imresize(img, [30 30], 'nearest');
        db{i} = rgb2lab(img);
    end
    
    save('db.mat', 'db');

end

