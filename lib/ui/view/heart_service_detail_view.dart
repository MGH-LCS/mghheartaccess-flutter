import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mghheartaccess/model/heart_center.dart';
import 'package:mghheartaccess/ui/shared/colors.dart';
import 'package:mghheartaccess/ui/view/base_view.dart';
import 'package:mghheartaccess/ui/viewmodel/heart_service_detail_model.dart';

class HeartServiceDetailView extends StatelessWidget {
  const HeartServiceDetailView(this.heartService, {super.key});

  final HeartService heartService;

  @override
  Widget build(BuildContext context) {
    return BaseView<HeartServiceDetailModel>(
        onModelReady: (model) async => await model.init(heartService),
        builder: (context, model, child) => DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('ECMO'),
                  bottom: const TabBar(
                    tabs: <Widget>[
                      Tab(
                        text: 'Checklist',
                      ),
                      Tab(
                        text: 'Guidelines',
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: null,
                  label: const Text(
                    "ECMO Hotline",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  backgroundColor: mgbRed,
                ),
                body: const SafeArea(
                  minimum: EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: TabBarView(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 16, 16, 100),
                          child: Column(
                            children: [
                              Text(
                                  "Call MGH ECMO Hotline at 857-310-0335 or call the operator at 617-726-2000 and page 29151"),
                              SizedBox(
                                height: 10,
                              ),
                              HtmlWidget('''
                        <hr/>
                        <p>When calling, please provide:</p>
<ul style="line-height: 1rem;">
  <li>Name, DOB, height, weight</li>
  <li>Admission Diagnosis</li>
  <li>Recent cardiac arrest?</li>
  <li>Currently on ECMO? VA, VV, or VAV ECMO?
    <ul>
      <li>Circuit type and flow (target 2 at minimum – goal 2.4L/min/M2); any difficulty maintaining flow</li>
      <li>Cannulation details (cannula size and location, presence of distal perfusion catheter?) </li>
    </ul>
  </li>

  <li>Current hemodynamic support
    <ul>
      <li>Pharmacologic: epinephrine, norepinephrine, vasopressin, milrinone, etc? dose?</li>
      <li>Mechanical support: IABP, Impella, etc</li>
    </ul>
  </li>
  <li>Last known neurologic status</li>
  <li>Major comorbidities and allergies</li>
  <li>All IV drips, significant medications (e.g. vasopressors, sedation, paralytics)</li>
  Tubes/Lines/Drains: arterial and venous access/lines, chest tubes, etc (Note: right upper extremity for saturation and arterial line or right ear for saturation are preferred over left)
  <li>Active bleeding? (anything > 100 cc/hr)</li>
  <li>Mechanical ventilator settings and duration of support</li>
  <li>Renal replacement therapy?</li>
  <li>Most recent ABG, BMP, CBC, coagulation studies and lactate (drawn within 1 hour of transport)</li>
  <li>Recent echocardiogram and imaging results (including CXR, chest CT, etc) Contact information for patient’s health care agent</li>
  <li>Receiving ECMO team member will provide:</li>
  <li>Decision regarding acceptance (Note: will require call-back to sending after discussion with ECMO response team)</li>
  <li>Any action/investigation recommended for optimization before transport</li>
</ul>

<hr/>

<p>For acccepted patients:</p>
<p>The referring center should contact Boston MedFlight 1-800-233-8998 (preferable) or other critical care transport (CCT) team per hospital protocol.</p>
<p>Arrange for a minimum of 2 units of PRBCs to travel with patient</p>
<p>If intubated, sedation and chemical paralytics recommended for transport</p>
<p>Prepare and provide transport team with an adequate quantity of vasoactive drips and other continuous infusions</p>
<p>If patient is being transported with perfusion from the sending facility, ensure perfusion has addressed any ECMO circuit incompatibilities with receiving center prior to transport</p>
<p>Please report any change in status prior to or during transport to MD Connect at 1-617-726-3384</p>
                        '''),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 16, 16, 100),
                          child: Column(
                            children: [
                              Text(
                                  "Call MGH ECMO Hotline at 857-310-0335 or call the operator at 617-726-2000 and page 29151"),
                              SizedBox(
                                height: 10,
                              ),
                              HtmlWidget('''
                        <hr/>
                        <p>Below are general guidelines for Extracorporeal Life Support (ECLS/ECMO) used at the MGH for adult medical patients. Final decisions regarding an individual patient's inclusion/exclusion should be made by ECLS certified faculty using appropriate clinical judgment. We encourage calls to MGH to discuss individual cases.</p>

<ul>
  <li>Usual medical and surgical treatments have failed, and the patient is at high risk of death without mechanical circulatory support including patients who are unable to separate from cardiopulmonary bypass.</li>
  <li>The patient must have a reasonable expectation of myocardial/pulmonary recovery with time OR be a candidate for consideration of a durable mechanical circulatory support device and/or transplantation.</li>
  <li>The patient should not have suffered catastrophic neurologic damage. Neurologic status should be assessed via clinical exam or imaging whenever possible.</li>
</ul>  

<h2>Indications for VA ECMO:</h2>
<ul>
  <li>Inadequate tissue perfusion and shock manifesting as hypotension and low cardiac output despite volume administration, inotropes and vasopressors, and standard therapies</li>
</ul>

<h2>Indications for VV ECMO:</h2>
<ul>
    <li>Acute respiratory failure of all causes when the risk of mortality is high as identified by a PaO2/FiO2 < 150 on FiO2 > 90%</li>
    <li>Uncompensated CO2 retention PaCO2 > 60, and pH < 7.25 with inability to mechanically ventilate</li>
    <li>Inability to achieve safe inflation pressures (Driving P ≤ 15 cm H2O or Pplat ≤ 30 cm HO)</li>
</ul>

<h2>Common indications:</h2>
<ul>
  <li>Cardiogenic shock: all causes</li>
  <li>Refractory VT / VF</li>
  <li>Cardiac arrest without ROSC</li>
  <li>Early failure post heart or lung transplant</li>
  <li>Pulmonary embolism</li>
  <li>Acute anaphylaxis</li>
  <li>Sepsis with profound cardiac depression</li>
  <li>Bridge to cardiac transplant / mech support</li>
  <li>Post cardiac surgery failure (unable to wean from CPB)</li>
</ul>

<h2>Common indications:</h2>
<ul>
  <li>Severe pneumonia or aspiration</li>
  <li>ARDS</li>
  <li>Acute lung failure (PGD) post transplant</li>
  <li>Pulmonary contusion</li>
  <li>Bridge to lung transplant</li>
  <li>Toxic inhalation</li>
  <li>Status asthmaticus</li>
  <li>Airway obstruction, i.e. mediastinal masses • Severe air leak syndrome</li>
</ul>

<h2>Absolute Contraindications to All Forms of ECMO:</h2>
<ul>
  <li>Non-recoverable multi-organ failure or neurologic disease</li>
  <li>Unwitnessed cardiac arrest or CPR > 30 min without ROSC</li>
  <li>Active severe bleeding</li>
  <li>Contraindication to anticoagulation or refusal to receive blood products</li>
  <li>Recent neurosurgical procedures or intracranial bleeding (within 10 days)</li>
  <li>End stage liver disease or renal disease on dialysis Absolute Contraindications to VA ECMO:</li>
  <li>Acute Aortic dissection</li>
  <li>Severe aortic valve regurgitation</li>
</ul>

<h2>Relative Contraindications to ECMO:</h2>
<ul>
  <li>Age > 70 years</li>
</ul>

<h2>Absolute Contraindications to VV ECMO:</h2>
<ul>
  <li>Severe right or left heart failure (Consider VA ECMO)</li>
  <li>BMI > 40</li>
  <li>Unknown neurologic status</li>
  <li>Multiple organ failure</li>
  <li>Prolonged mechanical ventilation</li>
  <li>Severe pulmonary hypertension in a non-transplant candidate</li>
  <li>Active malignancy, graft vs. host disease or significant immunosuppression</li>
</ul>

<h2>Typical Patient Profiles:</h2>

<h3>Veno-Arterial ECMO (Circulatory Support)</h3>
<h4>Cardiogenic Shock</h4>
<ol>
  <li>Cl < 2.2 L/min/m2 or SVO2 < 60% (on two inotro- pes)</li>
  <li>High biventricular filling pressures: PCW > 20, CVP > 15</li>
  <li>Rising lactate</li>
  <li>Worsening metabolic acidosis</li>
  <li>Hypotension with significant vasopressor require- ment (two or more of the following):
    <ul>
      <li>Norepinephrine ≥ 50 mcg/min - Vasopressin ≥ 0.04 units/min</li>
      <li>Phenylephrine ≥ 100 mcg/min - Epinephrine ≥ 5 mcg/min </li>
    </ul>
  </li>
</ol>

<p><strong>Unstable arrhythmias</strong></p>



<h3>Veno-venous ECMO (Lung Support)</h3>

<h4>Acute Respiratory Failure</h4>
<ol>
  <li>Sat ≤ 88% on FiO2 100% and PEEP ≥ 15, with plateau pressure ≥ 30cmH2O</li>
  <li>pH < 7.20</li>
  <li>FiO2 > 70% for Lung Transplant patient</li>
  <li>Normal RV/LV function</li>
  <li>Minimal vasopressor/inotrope requirements</li>
  <li>Paralysis, Inhaled Nitric Oxide or Epoprostenol and /or prone positioning attempted</li>
</ol>
                        '''),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
