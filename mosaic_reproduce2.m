function [ reproduced_image ] = mosaic_reproduce2( image, database_name )

    load(database_name)

    [rows cols channels] = size(image);
    image = rgb2lab(image);
    a = db{1,1};
    reproduced_image = zeros(rows, cols, channels);
    stepSize = size(db{1,1}, 1);
    
    for r = 1:stepSize:rows
        for c = 1:stepSize:cols

           sub_image = image(r:r+stepSize-1, c:c+stepSize-1, :);
           
           for a = 1:size(db, 2)
               struct_dist(1,a) = 1 - ssim(sub_image, db{1,a});
               distances(1,a) = mean2(sqrt( (db{1,a}(:,:,1) - sub_image(:,:,1)).^2 + (db{1,a}(:,:,2) - sub_image(:,:,2)).^2 + (db{1,a}(:,:,3) - sub_image(:,:,3)).^2 ));
           end
           
           % Normalize distance vectors
           struct_dist = struct_dist/norm(struct_dist);
           distances = distances/norm(distances);
           
           % Calculate total distance in both color and structural
           % dimensions
           for a = 1:size(distances, 2)
               total_dist(1,a) = sqrt( distances(a)^2 + struct_dist(a)^2 );
           end

           [value, index] = min(total_dist);
           %[value, index] = min(distances);
           reproduced_image(r:r+stepSize-1, c:c+stepSize-1, :) = db{1,index};
     
        end 
        disp([num2str(uint8((r/rows) * 100)), '% completed.']);
    end

    reproduced_image = lab2rgb(reproduced_image);

end

