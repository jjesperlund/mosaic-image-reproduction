function [ ] = optimizeDB( database_name, distance_threshold )
%%Function for optimizing image database

    load(database_name)
    test = db{1,1};
    db_size = size(db, 2);
    zeros_matrix = zeros(size(db{1,1}));
    new_database_index = 1;
    
    for i = 1:db_size
        current = db{1,i};
        
        for j = 1:db_size
            if max(max(max(current))) ~= 0 && max(max(max(db{1,j}))) ~= 0
                dist(1,j) = euclidean(current, db{1,j}, 'diff');
            end
        end
        
        [distance, index] = sort(dist);
        if distance(2) < distance_threshold
            closest = db{1, index(2)};
            im = getBestImage(current, closest);
            
            if im == current
                db{1,i} = zeros_matrix;
            else
                db{1, index(2)} = zeros_matrix;
            end
       
            db_optimized{new_database_index} = im;
            new_database_index = new_database_index + 1;
     
        end
        
    end
    
    db = db_optimized;
      
    save('db_optimized_new_2.mat', 'db')

end

function [d] = euclidean(img1, img2, type)

     if type == 'diff'
        d = mean2(sqrt( (img1(:,:,1) - img2(:,:,1)).^2 + (img1(:,:,2) - img2(:,:,2)).^2 + (img1(:,:,3) - img2(:,:,3)).^2 ));
     elseif type == 'dist'
          d1 = mean2( sqrt( (img1(:,:,1)).^2 + (img1(:,:,2)).^2 + (img1(:,:,3)).^2 ) );
          d2 = mean2( sqrt( (img2(:,:,1)).^2 + (img2(:,:,2)).^2 + (img2(:,:,3)).^2 ) );
          [max_dist, index] = max([d1,d2]);
          d = index;
     end
     
end

function [ best_img ] = getBestImage(current, closest)
% Calculates the image with the maximum distance in CIELAB color space
% Greater distance = better color

    bestImageIndex = euclidean(current, closest, 'dist');
    
    if bestImageIndex == 1
        best_img = current;
    else
        best_img = closest;
    end

end


