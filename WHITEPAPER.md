# Standardising on NixOS - A Kartoza White Paper

Tim Sutton, May 2024

## Abstract:

This document outlines the strategic benefits and operational enhancements proposed through the adoption of NixOS within our organization. It addresses key arguments supporting the transition, tackles common concerns through an FAQ section, and projects future initiatives to further standardize and secure our IT environment. The primary aim is to enhance efficiency, reduce variability, and ensure a secure, standardized IT infrastructure that supports remote work and scales effectively with organizational growth.



## Background

Allowing users to choose their operating system can increase comfort and productivity, especially if they're accustomed to a specific environment. This flexibility can be great for user satisfaction but might introduce variability that complicates support and security management. Using VMs for mission-critical applications is a solid strategy to maintain control over those environments without imposing too much on users' personal preferences.

On the other hand, standardizing on a single operating system like NixOS across all user hardware can greatly simplify management, enhance security, and ensure consistency in the work environment. This approach can also leverage NixOS’s reproducibility and configuration management capabilities to streamline deployments and updates. However, it might require more training and support for users not familiar with NixOS.

Each strategy has different implications for administration overhead, security, user flexibility, and resource allocation.

Given these priorities, standardizing on NixOS for all user hardware will align better with our goals. It offers a high degree of control over the operating system environment, which can significantly reduce variability and risk. Also, NixOS’s configuration management capabilities ensure that all systems are compliant with our corporate policies right from the start.

Standardization will also simplify the support process, especially for our team who are all remote workers. This will lead to fewer surprises in the system setups and fewer unique issues related to different operating systems.

While it may require some initial training and adjustment for our team, the long-term benefits in terms of security and simplified support could outweigh these upfront costs.

## Standardisation Versus Individuality

a system that balances the need for standardization with the potential for individual contributions and flexibility. By using a shared Git repository for your NixOS configurations, you're essentially allowing for a collaborative approach to system management. Users who are technically adept can directly contribute to the system's evolution, while those who are less technical still have a pathway to suggest changes that can be implemented by the more experienced team members. This can help mitigate feelings of restriction and loss of individuality, as it gives everyone a voice in the development of their work environment.

This approach also keeps your configurations transparent and version-controlled, which is great for accountability and rollbacks in case something goes wrong. It might be helpful to establish clear guidelines on how changes are proposed, reviewed, and deployed, ensuring that updates are managed efficiently without compromising the system's stability or security.


## Branded Experience



The next argument is about creating a branded experience. When people work in a desktop environment which has got corporate branding, they are going to remember that they're in a work mode rather than, for example, on a leisure time mode. And also, when they are sharing their screen with clients or taking screenshots for documentation, there'll be a consistency and branding that gets permeated into the materials that you produce just because of the way that all of our desktops have been standardized and include our branding elements into the desktop.


 Standardizing the desktop environment with corporate branding not only reinforces the professional context but also ensures consistency and a polished appearance in external communications, like client presentations or shared documentation. This can enhance your organization's professional image and ensure that employees are always presenting a unified front.

Integrating branding elements into the desktop environment can also subtly reinforce company values and culture, which is particularly important in a remote work setting where physical office cues are absent. It can help maintain a sense of connection and identity among team members.


## Repeatable Development Environments

So moving on from that is the idea of catering for repeatable development environments. So if people build their own desktops and use Nix, for example, in a VM machine, you create this highly inefficient setup where you basically build into your machine, you create a VM, you go into the VM, and then you go into your development environment. So you've got three abstraction layers. There's overhead of hardware, software, and mental cognitive friction. Whereas in my approach, if everything is done with the NixOS being on the base system, all of the projects that you set up, you'll standardize them to have Nix.shell or shell.nix during environments. For each project they go into, as they see in other projects, they will context switch automatically, and all the development tools and environment will automatically be provisioned to work on that project. It also means that it's easier for staff to come and go from projects, or new staff who are arriving in an organization, who quickly get up to speed to how to work on the different projects, because they don't have to spend a lot of time trying to replicate the development environment first.

Focusing on efficiency and ease of onboarding by using NixOS to manage development environments directly on the user's primary system. Eliminating the need for multiple abstraction layers not only streamlines the development process but also reduces the potential for errors and inconsistencies that can arise from having to manage and synchronize multiple environments. This can significantly decrease setup times and the cognitive load on developers, allowing them to focus more on coding and less on configuring their tools.

By standardizing the development environments using shell.nix, you ensure that all necessary dependencies and tools are automatically handled and consistent across all projects. This uniformity makes it much easier for existing staff to switch between projects without friction and allows new staff to become productive more quickly, as they don't need to navigate through a complex setup process.

This setup could also facilitate better collaboration and troubleshooting among team members, as everyone would be working within the same system parameters. It sounds like a robust plan that could greatly enhance productivity and collaboration within your team.


## Trope Benefits of NixOS

So the next point I'd like to raise is that I haven't even mentioned any of the sort of standard trope benefits of MixOS, which are about having a repeatable platform, a declarative platform, and having an environment where we always have a known working base system, and also that everything that we do to change, we can track and iterate and roll back and deal with poor choices as equally well as we do with good choices.


The inherent benefits of NixOS, such as its declarative and reproducible nature, are significant advantages for any organization, especially in maintaining and managing IT environments efficiently.

By defining system configurations declaratively, you ensure that your setups are repeatable and predictable, which is essential for both security and stability. This means every system setup or update can be treated as code and version-controlled, making it much easier to manage changes over time. Moreover, the ability to rollback changes reliably is a critical feature, allowing your team to quickly revert to a known good state if something goes wrong, minimizing downtime and disruption.

These capabilities not only boost the operational efficiency but also enhance the overall resilience of your IT infrastructure. By implementing NixOS and leveraging these features, you're setting a foundation that supports both stability and agility, which is crucial for rapidly adapting to new requirements or resolving issues.

This approach aligns well with best practices in modern IT management, emphasizing automation, consistency, and minimal manual intervention.


## Additional Arguments


Security Enhancements: Emphasize NixOS's unique model for handling packages and dependencies, which can lead to fewer security vulnerabilities. The isolated nature of its packages prevents the cascading security issues common in other distributions.

Cost Efficiency: Highlight potential cost savings from reduced need for IT support and troubleshooting due to the standardized environments. This can lead to lower operational costs over time as the system becomes more streamlined and less prone to user-induced errors.

Scalability: Discuss how NixOS's configuration management system can easily scale with the organization, supporting environments from a few machines to thousands without significant changes to the infrastructure management practices.

Eco-system Compatibility: While focusing on the benefits, it’s also good to address how NixOS fits within the broader ecosystem of tools your organization uses. Compatibility with popular DevOps tools and workflows can be a persuasive point if relevant.

Innovation and Recruitment: Positioning your organization as one that uses cutting-edge technology like NixOS can be attractive to potential new hires, particularly those who are looking for innovative and technically challenging environments.


## NixOS Falacies

The one is to address fallacies about NixOS. So, for example, NixOS is often considered Linux in hard mode, but for practical purposes, once the user has a deployed system, laptop, or desktop, and in front of them, they've got a GNOME desktop environment and all their software provisioned, it's no different or more difficult to use than any other distribution. And if they have to be involved in package management related activities, I think NixOS package management tools are different, but equally easy to get to grips with. And plus, you've got three levels of abstraction for package management. So you can install things in your user space. You can install things in Nix shell environments. You can install things at the system level. So there's a lot of flexibility available there that you wouldn't get on other systems.


Here are a few additional arguments you could use to further debunk common fallacies and enhance your case:

Learning Curve vs. Long-Term Benefits: While NixOS may have a steeper learning curve, the long-term benefits of stability, reproducibility, and security outweigh the initial investment in learning the system. Highlighting the comprehensive documentation and community support can also reassure users that help is readily available.

Customization and Control: Stress the unparalleled level of control and customization that NixOS offers, which can be a significant advantage for developers and IT professionals. This flexibility allows users to create highly tailored environments that suit specific project needs without affecting the global system state.

Integration Capabilities: Point out how well NixOS plays with other tools and technologies, especially in containerization and virtualization, which are pivotal in modern development environments. NixOS's ability to seamlessly integrate with Docker, for instance, can be a strong point in its favor.

Community and Innovation: Mention the vibrant and innovative NixOS community, which is continually developing new solutions and improvements. This community not only ensures that NixOS stays at the cutting edge but also provides a resource for users seeking advice or collaboration.


## Remote Management

Bullet number one is remote management and maintenance and upgrading of machines. 

## Media creation

## Work modalities that we can support

* media workstation, 
* GIS workstation, 
* developer workstation, 
* administration workstation, 
* content creation for training 
* training workstation
* administration user workstation
* DevOps workstation.

All of those are the different modalities you can support on the one platform.

## Mac Users

Mac Transition Strategy: Clearly outline the phased approach for transitioning Mac users to NixOS. This could include providing training and resources tailored for Mac users to get accustomed to NixOS gradually. Emphasize the long-term benefits of this switch, such as enhanced security, reduced variability, and the robust, unified environment that NixOS offers.

## After this

What's Next: Enhancing Our IT Ecosystem Post-Transition

Continued Standardization: After successfully transitioning to NixOS, our focus will shift towards further standardizing security practices across the organization. This includes mandatory use of password managers to enhance security and streamline access management.

Development of Best Practice Materials: We will create comprehensive guidelines that outline the norms and practices for security best practices. These materials will serve as a resource for all team members to ensure everyone is aligned with our security standards.

Provenance and Security of Code: Emphasizing the importance of code provenance, we will implement measures to ensure that all code used within our systems is secure, traceable, and compliant with our organizational standards. This will involve rigorous vetting processes and possibly the integration of tools that enhance transparency and security in code deployment.

Training and Support: Recognize the need for ongoing training and support to help all team members adapt to the new systems and practices. This will include specific sessions focused on security practices, the use of new tools, and best practices for maintaining a secure and efficient work environment.

These initial changes are just the beginning of a broader initiative aimed at enhancing operational efficiency, security, and compliance. It will also help in setting the stage for the continuous evolution of your IT infrastructure, aligning with industry best practices and technological advancements.


## FAQ

FAQ Section

Question: What if I need to run Windows applications?

Answer:

* Option One: Use a Virtual Machine to run a full Windows environment. This approach provides the most compatibility for Windows-specific applications and is best for users who need extensive Windows functionality.
* Option Two: Utilize Wine, which allows you to run many Windows applications directly on Linux systems without needing a full Windows OS.
* Option Three: Employ Bottles, a containerized version of Wine that simplifies the management of Windows applications, enhancing both security and ease of use.
(Additional Common Questions)

Question: How does NixOS handle updates and system changes?

Answer: NixOS update are atomic and transactional which allows for safe updates and easy rollbacks, ensuring system stability.

Question: Can I customize my NixOS environment if it's standardized?
Answer: Users can propose changes or additions to the system configurations via the shared Git repository, allowing for controlled customization and innovation.

Question: What support is available for new users unfamiliar with NixOS?

Answer: Detail the training resources, community forums, and internal support structures that are in place to help new users get up to speed.


Question: What about Mac users in our organization?
Answer: Mac users can continue using their current devices. However, once these devices reach their end-of-life, the organization will transition to a managed NixOS environment rather than replacing old Macs. This ensures a smooth transition and allows time for users to familiarize themselves with the new system through dual-use or training.



Mac Users:

Current Mac users will continue with their existing systems until end-of-life, after which they will transition to NixOS.
Updates and System Changes:

NixOS handles updates atomically and transactionally, allowing for easy rollbacks and minimal downtime.
Customization Capabilities:

Despite standardization, users can propose system modifications or additions through a managed repository, allowing controlled customization.
Support for New Users:

Extensive support and training will be available to ensure all users are comfortable and proficient with NixOS.
