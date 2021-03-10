%MAXIMUM of the current function is 9.5
%best sol from each generation is displayed
%the approach to the peak can clearly be seen from the output
%n=No. of bits. The more bits you add, the bigger your
%solution space becomes.
n=6;
%m=population size
m=8;
%survival=the percentage of the generation that survive to reproduce 
survival=0.5*m;
%randomly initialise a population of binary bits
pop=round(rand(m,n));
%no. of generations 
generation=4;
for i=1:generation
    c=zeros(m,1);
    %to convert a certain binary sequence to decimal values 
    for i=1:m
        j=n;
        while j > 0
            if(pop(i,j)) == 1
                c(i)=c(i)+ 2^(-(j-n));

            end
            j=j-1;
        end
    end
    c;
    %cost=-0.5x^2+3x+5. Modify it to optimize any singe variable function you
    %like
    c=-0.5*(c.^2)+3*c+5*(ones(m,1));
    [c,ind]=sort(c,'descend');
    %natural seletion
    elite=c(1:survival);
    elite(1)
    %roulette wheel
    minimum=min(c);
    minimum=minimum*(ones(survival,1));
    elite=elite-minimum;
    s=sum(elite);
    prob=zeros(survival,1);
    for i=1:survival
        prob(i)=elite(i)/s;
    end    
    prob;
    prob=cumsum(prob);
    parents=zeros(survival,n);
    for i=1:survival
        d=rand();
        k=1;
        while d>prob(k)
            k=k+1;
        end
        parents(i,:)=pop(ind(k),:);
    end
    parents;
    %crossover,i.e mating
    children=zeros(survival,n);
    for i=1:2:survival
        x=randi([1,n]);
        children(i,1:x)=parents(i,1:x);
        children(i,x:n)=parents(i+1,x:n);
        children(i+1,1:x)=parents(i+1,1:x);
        children(i+1,x:n)=parents(i,x:n);
    end    
    children;
    pop=[parents;children];
    %mutations!!!
    mu=0.2;
    mutations=round(mu*((m-1)*n));
    mut_row=randi(size(pop,1),[1,mutations]);
    mut_col=randi(size(pop,2),[1,mutations]);
    for i=1:mutations
        if pop(mut_row(i),mut_col(i)) == 1
            pop(mut_row(i),mut_col(i))=0;
        else
            pop(mut_row(i),mut_col(i))=1;
        end
    end    
    pop;
end


